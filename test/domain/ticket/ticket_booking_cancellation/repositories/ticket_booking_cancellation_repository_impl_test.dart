import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/repositories/ticket_booking_cancellation_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedTicketBookingCancellationCodeDataSource
    extends TicketBookingCancellationRemoteDataSource {
  Future<TicketBookingDetailCancellationDomain> getTicketBookingReject(
      TicketBookingCancellationArgumentDomain argumentDomain) async {
    Map<String, dynamic> map = json.decode(fixture(
        "ticket/ticket_booking_cancellation/ticket_booking_cancellation_mock.json"));
    return Future.value(TicketBookingDetailCancellationDomain.fromMap(map));
  }

  @override
  Future<TicketBookingDetailCancellationDomain> getTicketCancellationDetail(
      TicketBookingCancellationArgumentDomain argument) {
    Map<String, dynamic> map = json.decode(fixture(
        "ticket/ticket_booking_cancellation/ticket_booking_cancellation_mock.json"));
    return Future.value(TicketBookingDetailCancellationDomain.fromMap(map));
  }
}

class MockedTicketBookingCancellationDataSourceException
    extends TicketBookingCancellationRemoteDataSource {
  @override
  Future<TicketBookingDetailCancellationDomain> getTicketCancellationDetail(
      TicketBookingCancellationArgumentDomain argumentDomain) async {
    throw Future.value(Exception());
  }
}

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  group('TicketBookingCancellationRepositoryImpl group test', () {
    test('TicketBookingCancellationRepositoryImpl test for internet success',
        () async {
      TicketBookingCancellationRepositoryImpl();

      TicketBookingCancellationRepositoryImpl repository =
          TicketBookingCancellationRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedTicketBookingCancellationCodeDataSource(),
      );

      repository.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''),
      );
    });

    test('TicketBookingCancellationRepositoryImpl test for internet failure',
        () async {
      TicketBookingCancellationRepositoryImpl();

      TicketBookingCancellationRepository repository =
          TicketBookingCancellationRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedTicketBookingCancellationCodeDataSource(),
      );

      repository.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''),
      );
    });

    test('TicketBookingCancellationRepositoryImpl Exception test', () async {
      TicketBookingCancellationRepositoryImpl();

      TicketBookingCancellationRepositoryImpl.setMockInternet(
          InternetConnectionInfoMocked());

      TicketBookingCancellationRepository repository =
          TicketBookingCancellationRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedTicketBookingCancellationDataSourceException(),
      );

      try {
        await repository.getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain(
              confirmationNo: '', cancellationReason: ''),
        );
      } catch (error) {
        return (error);
      }
    });
  });
}
