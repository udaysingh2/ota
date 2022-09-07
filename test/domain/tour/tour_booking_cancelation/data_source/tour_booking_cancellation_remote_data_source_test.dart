import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tour_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';

import '../../../../mocks/fixture_reader.dart';

class MockTourBookingCancellationGraphQl implements GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture(
      "tour/tour_booking_cancellation/tour_booking_cancellation_success_mock.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
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
  TourBookingCancellationArgumentDomain argument =
      TourBookingCancellationArgumentDomain(
          cancellationReason: "", confirmationNo: "");

  group("Tour Booking Cancellation data source group", () {
    test('Tour Booking test', () async {
      TourBookingCancellationRemoteDataSource
          tourBookingCancellationRemoteDataSource =
          TourBookingCancellationRemoteDataSourceImpl();
      tourBookingCancellationRemoteDataSource =
          TourBookingCancellationRemoteDataSourceImpl(
              graphQlResponse: MockTourBookingCancellationGraphQl());
      TourBookingCancellationRemoteDataSourceImpl.setMock(
          MockTourBookingCancellationGraphQl());
      tourBookingCancellationRemoteDataSource
          .getTourCancellationDetail(argument);
    });
  });
}
