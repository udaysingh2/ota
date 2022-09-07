import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../../../mocks/fixture_reader.dart';

class MockEnglishGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("translation/english_translation_data_mock.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      //This is mandatory for crashlytics
      required String queryName,
      String? bookingUrn,
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

class MockThaiGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("translation/thai_translation_data_mock.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      //This is mandatory for crashlytics
      required String queryName,
      String? bookingUrn,
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
