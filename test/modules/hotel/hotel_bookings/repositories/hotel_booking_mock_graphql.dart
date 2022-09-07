import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../../../../mocks/fixture_reader.dart';

class MockHotelBookingDetailGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("hotel/hotel_booking/hotel_booking_list.json"));
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
