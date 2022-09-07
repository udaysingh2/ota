import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedBookingCancellationResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture(
      "ticket/ticket_booking_cancellation/ticket_booking_cancellation_mock.json"));

  @override
  Future<QueryResult> getGraphQlResponse({
    String query = '',
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
    String? acceptLanguage,
    String? bookingUrn,
    required String queryName,
    bool authRequired = true,
  }) async {
    map["removePromoCode"] = map;
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
  group('Ticket Booking Code Remote Data Source Group Test', () {
    test('Ticket Booking Mock Data Source Test', () async {
      TicketBookingCancellationRemoteDataSourceImpl.setMock(
        MockedBookingCancellationResponseImpl(),
      );

      TicketBookingCancellationRemoteDataSource remoteDataSource1 =
          TicketBookingCancellationRemoteDataSourceImpl();

      remoteDataSource1.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''),
      );
    });

    test('Ticket Booking Remote Data Source Test', () async {
      TicketBookingCancellationRemoteDataSource remoteDataSource =
          TicketBookingCancellationRemoteDataSourceImpl(
        graphQlResponse: MockedBookingCancellationResponseImpl(),
      );

      remoteDataSource.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''),
      );
    });

    test('Ticket Booking graphQlResponse null Test', () async {
      TicketBookingCancellationRemoteDataSource remoteDataSource1 =
          TicketBookingCancellationRemoteDataSourceImpl(
        graphQlResponse: null,
      );

      remoteDataSource1.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''),
      );
    });
  });
}
