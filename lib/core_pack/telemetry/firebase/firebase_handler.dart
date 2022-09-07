import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/channels/log_crashlytics_invoke/usecases/log_crashlytics_use_cases.dart';

class FirebaseCrashlytics {
  FirebaseCrashlytics._internal();
  static FirebaseCrashlytics shared = FirebaseCrashlytics._internal();
  factory FirebaseCrashlytics() {
    return shared;
  }

  void pushRawCrashReports(
      {String? className, String? message, String? stackTrace}) {
    if (message == null) return;
    if (className == null) return;
    if (message.isEmpty) return;
    if (className.isEmpty) return;
    LogCrashlyticsUseCases logCrashlytics = LogCrashlyticsUseCasesImpl();
    logCrashlytics.invokeMethod(
        methodName: "logCrashlytics",
        arguments: LogCrashlyticsArgumentModelChannel(
          className: className,
          message: message,
          stackTrace: stackTrace ?? "",
        ));
  }

  void pushResultChannelReportInvoke({required Exception? exception}) {
    if (exception == null) return;
    pushRawCrashReports(
      className: "OtaChannelInvokeException.dart",
      message: exception.toString(),
    );
  }

  void pushResultChannelReportHandler({required Exception? exception}) {
    if (exception == null) return;
    pushRawCrashReports(
      className: "OtaChannelHandlerException.dart",
      message: exception.toString(),
    );
  }

  void pushQueryResultReport(
      {required QueryResult? queryResult,
      required String query,
      required String queryName}) {
    if (queryResult == null) return;
    if (!queryResult.hasException) return;
    Map<String, String> map = {
      "exception": queryResult.exception?.toString() ?? "NULL",
      "query": query
    };

    pushRawCrashReports(
      className:
          "${queryName.trim().isNotEmpty ? queryName : "graphql_client"}.dart",
      message: jsonEncode(map),
    );
  }

  void pushIfTokenGenerationFailed({required bool isFromApi}) {
    if (isFromApi) {
      pushRawCrashReports(
        className: "graphqlClientTokens.dart",
        message:
            "Token updating failed from method channel handler Due to 401 Error from backend.",
      );
    } else {
      pushRawCrashReports(
        className: "graphqlClientTokens.dart",
        message:
            "Token updating failed from method channel handler Due to Time out decode from front end.",
      );
    }
  }
}
