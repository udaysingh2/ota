import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class MockCarBookingMailerGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("carRental/car_booking_mailer_mock.json"));
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
  CarBookingMailerArgumentDomain argument =
      CarBookingMailerArgumentDomain(confirmNo: "", mailId: "", bookingUrn: "");

  group("Car Booking Mailer data source group", () {
    test('Car Booking Mailer test', () async {
      CarBookingMailerRemoteDataSource bookingMailerRemoteDataSource =
          CarBookingMailerRemoteDataSourceImpl();
      bookingMailerRemoteDataSource = CarBookingMailerRemoteDataSourceImpl(
          graphQlResponse: MockCarBookingMailerGraphQl());
      CarBookingMailerRemoteDataSourceImpl.setMock(
          MockCarBookingMailerGraphQl());
      bookingMailerRemoteDataSource.sendCarBookingMailer(argument);
    });
  });
}
