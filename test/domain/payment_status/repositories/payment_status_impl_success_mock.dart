import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../../../mocks/fixture_reader.dart';

class MockPaymentStatusGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture('payment_status/payment_initiate.json'));
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

class MockPaymentStatusGraphQl1 implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture('payment_status/payment_initiate_data.json'));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      //This is mandatory for crashlytics
      required String queryName,
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
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
