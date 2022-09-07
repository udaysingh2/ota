import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_remote_data_source.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

import '../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture(
      "hotel_booking_cancellation/hotel_booking_cancellation_details.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      //This is mandatory for crashlytics
      required String queryName,
      bool authRequired = true}) async {
    map["rejectBooking"] = map;
    return QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HotelBookingCancellationArgument argument =
      HotelBookingCancellationArgument(confirmNo: '', reason: 'Testing file');

  group("Hotel booking cancellation remote data source group", () {
    test('Hotel booking cancellation remote data source', () async {
      HotelBookingCancellationRemoteDataSource
          hotelBookingCancellationRemoteDataSource =
          HotelBookingCancellationRemoteDataSourceImpl();
      hotelBookingCancellationRemoteDataSource =
          HotelBookingCancellationRemoteDataSourceImpl(
              graphQlResponse: _MockedGraphQlResponseImpl());
      hotelBookingCancellationRemoteDataSource
          .getHotelBookingCancellationData(argument);
    });
  });
}
