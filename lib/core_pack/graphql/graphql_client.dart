import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/app_version.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';
import 'package:ota/core_pack/telemetry/firebase/firebase_handler.dart';
// Disable SSL Pinning for MVP1
// import 'package:ota/core_pack/graphql/ssl_certificate_helper.dart';
import 'package:ota/debug_helper/debug_log_bloc.dart';
import 'package:ota/debug_helper/debug_utilities.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

// Disable SSL Pinning for MVP1
// import 'package:http/io_client.dart';

import 'auth_helper.dart';

const _kTimeoutInterval = 1;
const int _kTokenRetryCount = 3;

///Timeout required for access token retreval.
const int _kRefreshTokenTimeoutWaitInSec = 30;
// ignore: provide_deprecation_message
@deprecated
Future<QueryResult> getGraphQlResponse(
    {String query = '',
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
    String? acceptLanguage,
    String? bookingUrn,
    bool authRequired = true}) async {
  //This is depricated function so hardcoded
  Map<String, String> header = {
    "Content-type": "application/json",
    "Accept-Language": acceptLanguage ?? AppConfig().appLocale.languageCode,
    "Accept-Charset": "utf-8",
    "App-Version": kAppVersion,
    "Build-Number": '$kBuildNumber',
  };
  addBookingUrn(header, bookingUrn);
  await AuthHelper().addTokenInfo(header, authRequired: authRequired);
  printDebug("Header: $header");

  final ValueNotifier<GraphQLClient> graphqlClient = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(
        //This is depricated function so hardcoded.
        getBaseUrl(),
        defaultHeaders: header,
      ),
    ),
  );

  return await graphqlClient.value
      .query(
    QueryOptions(
      fetchPolicy: fetchPolicy,
      document: gql(query),
    ),
  )
      .timeout(const Duration(minutes: _kTimeoutInterval), onTimeout: () {
    return QueryResult<Map<String, dynamic>>(
      source: QueryResultSource.network,
      exception: OperationException(),
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
  });
}

void addBookingUrn(Map<String, String> data, String? bookingUrn) {
  if (bookingUrn == null) return;
  if (bookingUrn.isEmpty) return;
  data["booking_urn"] = bookingUrn;
}

String getBaseUrl() {
  switch (EnviornmentExt.fromChannelData(env: envType)) {
    case Environment.dev:
      return graphQlBaseUrlDev;
    case Environment.alpha:
      return graphQlBaseUrlAlpha;
    case Environment.prod:
      return graphQlBaseUrlProd;
    default:
      return graphQlBaseUrlDev;
  }
}

abstract class GraphQlResponse {
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      //This is mandatory for crashlytics
      required String queryName,
      bool authRequired = true});
}

class GraphQlResponseImpl implements GraphQlResponse {
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      //This is mandatory for crashlytics
      required String queryName,
      bool authRequired = true}) async {
    if (!OtaChannelConfig.isModule) {
      QueryResult result = await getGraphQlForFlutterApp(
        acceptLanguage: acceptLanguage,
        query: query,
        authRequired: authRequired,
        fetchPolicy: fetchPolicy,
        queryName: queryName,
        bookingUrn: bookingUrn,
      );
      return result;
    }

    int kTokenRetry = 0;
    QueryResult? queryResult;
    DebugLog debugLog = DebugLog(
        logTitle: queryName.trim().isEmpty ? "Graphql Query" : queryName,
        dateTime: DateTime.now());
    bool isFromApi = true;
    while (kTokenRetry <= _kTokenRetryCount) {
      LoginModel loginModel = getLoginProvider();
      isFromApi = true;
      // Disable SSL Pinning for MVP1
      // IOClient ioClient = await SslCertificateHelper.shared.getIOClient();
      if (AuthHelper.isTokenExpiredFromAccessToken(
          loginModel.data?.accessToken)) {
        await checkAndRefreshTokenFromAccessToken(loginModel.data?.accessToken);
        kTokenRetry++;
        isFromApi = false;
        if (kTokenRetry <= _kTokenRetryCount) continue;
      }

      Map<String, String> header = {
        "Content-type": "application/json",
        "Accept-Language": acceptLanguage ?? AppConfig().appLocale.languageCode,
        "Accept-Charset": "utf-8",
        "userType": loginModel.userType.getSuperAppString(),
        "App-Version": kAppVersion,
        "Build-Number": '$kBuildNumber',
      };
      addBookingUrn(header, bookingUrn);
      await AuthHelper().addTokenInfo(header, authRequired: authRequired);
      if (DebugUtils.isBuildForDebug()) {
        debugLog.logStrings.add(DebugLogString(
            logTitle: "Graphql URL",
            logsDescription: loginModel.env.getBaseUrl()));
        debugLog.logStrings.add(DebugLogString(
            logTitle: "Header Info", logsDescription: header.toString()));
        printDebug("Header: $header");
        printDebug("query: $query");
        debugLog.logStrings.add(DebugLogString(
            logTitle: "Graphql query", logsDescription: query.toString()));
      }
      final ValueNotifier<GraphQLClient> graphqlClient = ValueNotifier(
        GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink(
            loginModel.env.getBaseUrl(),
            defaultHeaders: header,
            // httpClient: ioClient,
          ),
        ),
      );

      queryResult = await _makeApiCall(
          graphqlClient: graphqlClient, fetchPolicy: fetchPolicy, query: query);
      if (AuthHelper.isTokenExpiredFromQueryResult(queryResult)) {
        await checkAndRefreshTokenFromQueryResult(queryResult);
        kTokenRetry++;
        continue;
      } else {
        break;
      }
    }
    if (kTokenRetry > _kTokenRetryCount) {
      FirebaseCrashlytics.shared
          .pushIfTokenGenerationFailed(isFromApi: isFromApi);
    }
    if (DebugUtils.isBuildForDebug()) {
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Result",
          logsDescription: DebugUtils.getMapToString(queryResult?.data)));
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Has Exception",
          logsDescription: queryResult?.hasException.toString() ?? "NULL"));
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Exception",
          logsDescription: queryResult?.exception?.toString() ?? "NULL"));
      if (queryResult?.hasException ?? true) debugLog.setAsSad();
      DebugUtils.debugLogBloc.addDebugLog(debugLog);
    }
    FirebaseCrashlytics.shared.pushQueryResultReport(
        queryResult: queryResult, query: query, queryName: queryName);
    return queryResult!;
  }

  Future<void> checkAndRefreshTokenFromAccessToken(String? accessToken) async {
    final completer = Completer();
    StreamSubscription? subscription;
    subscription = AuthTokenRefresher.shared.stream.listen((event) {
      if (AuthTokenRefresher.shared.state ==
          AuthTokenRefresherState.refreshed) {
        completer.complete();
        subscription?.cancel();
      }
    });
    Future.delayed(const Duration(seconds: _kRefreshTokenTimeoutWaitInSec), () {
      completer.complete();
      subscription?.cancel();
    });

    AuthTokenRefresher.shared.checkAndRefreshTokenFromAccessToken(accessToken);
    return completer.future;
  }

  Future<void> checkAndRefreshTokenFromQueryResult(QueryResult result) async {
    final completer = Completer();
    StreamSubscription? subscription;
    subscription = AuthTokenRefresher.shared.stream.listen((event) {
      if (AuthTokenRefresher.shared.state ==
          AuthTokenRefresherState.refreshed) {
        completer.complete();
        subscription?.cancel();
      }
    });
    Future.delayed(const Duration(seconds: _kRefreshTokenTimeoutWaitInSec), () {
      completer.complete();
      subscription?.cancel();
    });
    AuthTokenRefresher.shared.checkAndRefreshTokenFromResponse(result);
    return completer.future;
  }

  Future<QueryResult> getGraphQlForFlutterApp(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      required String queryName,
      bool authRequired = true}) async {
    DebugLog debugLog = DebugLog(
        logTitle: queryName.trim().isEmpty ? "Graphql Query" : queryName,
        dateTime: DateTime.now());
    LoginModel loginModel = getLoginProvider();
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept-Language": acceptLanguage ?? AppConfig().appLocale.languageCode,
      "Accept-Charset": "utf-8",
      "userType": loginModel.userType.getSuperAppString(),
      "App-Version": kAppVersion,
      "Build-Number": '$kBuildNumber',
    };
    addBookingUrn(header, bookingUrn);

    // Disable SSL Pinning for MVP1
    // IOClient ioClient = await SslCertificateHelper.shared.getIOClient(isExternal: false);
    await AuthHelper().addTokenInfo(header, authRequired: authRequired);
    if (DebugUtils.isBuildForDebug()) {
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql URL",
          logsDescription: loginModel.env.getBaseUrl()));
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Header Info", logsDescription: header.toString()));
      printDebug("Header: $header");
      printDebug("query: $query");
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql query", logsDescription: query.toString()));
    }
    final ValueNotifier<GraphQLClient> graphqlClient = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(
          loginModel.env.getBaseUrl(),
          defaultHeaders: header,
          // httpClient: ioClient,
        ),
      ),
    );
    QueryResult? queryResult = await graphqlClient.value
        .query(
      QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    )
        .timeout(const Duration(minutes: _kTimeoutInterval), onTimeout: () {
      return QueryResult(
        source: QueryResultSource.network,
        exception: OperationException(),
        options: QueryOptions(
          fetchPolicy: fetchPolicy,
          document: gql(query),
        ),
      );
    });
    if (DebugUtils.isBuildForDebug()) {
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Graphql Result",
          logsDescription: DebugUtils.getMapToString(queryResult.data)));
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Has Exception",
          logsDescription: queryResult.hasException.toString()));
      debugLog.logStrings.add(DebugLogString(
          logTitle: "Exception",
          logsDescription: queryResult.exception?.toString() ?? "NULL"));
      if (queryResult.hasException) debugLog.setAsSad();
      DebugUtils.debugLogBloc.addDebugLog(debugLog);
    }
    return queryResult;
  }

  Future<QueryResult> _makeApiCall(
      {required ValueNotifier<GraphQLClient> graphqlClient,
      required FetchPolicy fetchPolicy,
      required String query}) async {
    return await graphqlClient.value
        .query(
      QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    )
        .timeout(const Duration(minutes: _kTimeoutInterval), onTimeout: () {
      return QueryResult(
        source: QueryResultSource.network,
        exception: OperationException(),
        options: QueryOptions(
          fetchPolicy: fetchPolicy,
          document: gql(query),
        ),
      );
    });
  }
}

class GraphQlResponseMock implements GraphQlResponse {
  Map<String, dynamic>? result;
  OperationException? exception;
  FutureOr? completion;
  GraphQlResponseMock({this.result, this.exception, this.completion});
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      //This is mandatory for crashlytics
      required String queryName,
      bool authRequired = true}) async {
    if (completion != null) await completion;
    return QueryResult(
      source: QueryResultSource.optimisticResult,
      data: result,
      exception: exception,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
  }
}
