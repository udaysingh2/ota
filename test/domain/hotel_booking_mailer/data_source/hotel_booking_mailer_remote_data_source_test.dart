import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/data_sources/hotel_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';

import '../../../mocks/fixture_reader.dart';

class MockHotelBookingMailerGraphQl implements GraphQlResponse {
  Map<String, dynamic> map = json.decode(
      fixture("hotel/hotel_booking_mailer/hotel_booking_mailer_mock.json"));
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
  HotelBookingMailerArgumentDomain argument = HotelBookingMailerArgumentDomain(
      confirmNo: "", mailId: "", bookingUrn: "");

  group("Hotel Booking Mailer data source group", () {
    test('Hotel Booking Mailer test', () async {
      HotelBookingMailerRemoteDataSource bookingMailerRemoteDataSource =
          HotelBookingMailerRemoteDataSourceImpl();
      bookingMailerRemoteDataSource = HotelBookingMailerRemoteDataSourceImpl(
          graphQlResponse: MockHotelBookingMailerGraphQl());
      HotelBookingMailerRemoteDataSourceImpl.setMock(
          MockHotelBookingMailerGraphQl());
      bookingMailerRemoteDataSource.sendHotelBookingMailer(argument);
    });
  });
}
