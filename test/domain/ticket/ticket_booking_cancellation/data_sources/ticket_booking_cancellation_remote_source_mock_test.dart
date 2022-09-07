import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_source_mock.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  test(
      'For class TicketBookingCancellationMockDataSourceImpl ==> getTicketCancellationDetail Test',
      () async {
    TicketBookingCancellationRemoteDataSource dataSource =
        TicketBookingCancellationMockDataSourceImpl();

    final result = await dataSource.getTicketCancellationDetail(args());

    expect(result, isA<TicketBookingDetailCancellationDomain>());
  });
}

TicketBookingCancellationArgumentDomain args() =>
    TicketBookingCancellationArgumentDomain(
        confirmationNo: '', cancellationReason: '');
