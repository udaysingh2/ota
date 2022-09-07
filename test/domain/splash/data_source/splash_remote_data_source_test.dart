import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';

import '../../../mocks/fixture_reader.dart';

class SplashMockPopupGraphQl implements GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture("splash/splash_model.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      //This is mandatory for crashlytics
      required String queryName,
      bool authRequired = true}) async {
    QueryResult queryResult = QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
    return queryResult;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group(" splash remote data source group", () {
    test(' splash test', () async {
      SplashRemoteDataSource splashRemoteDataSource =
          SplashRemoteDataSourceImpl();
      splashRemoteDataSource =
          SplashRemoteDataSourceImpl(graphQlResponse: SplashMockPopupGraphQl());
      SplashRemoteDataSourceImpl.setMock(SplashMockPopupGraphQl());
      splashRemoteDataSource.getSplashData();
    });
  });
}
