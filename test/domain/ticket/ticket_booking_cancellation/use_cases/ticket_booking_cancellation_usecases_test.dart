import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/data_sources/ticket_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/repositories/ticket_booking_cancellation_repository_impl.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/use_cases/ticket_booking_cancellation_usecases.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedTicketBookingCancellationUseCase
    implements TicketBookingCancellationRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  TicketBookingCancellationRemoteDataSource?
      ticketBookingCancellationRemoteDataSource;

  Future<Either<Failure, TicketBookingDetailCancellationDomain?>>
      getTicketBookingReject(TicketBookingCancellationArgumentDomain argument) {
    Map<String, dynamic> map = json.decode(fixture(
        "ticket/ticket_booking_cancellation/ticket_booking_cancellation_mock.json"));
    return Future.value(
        Right(TicketBookingDetailCancellationDomain.fromMap(map)));
  }

  @override
  Future<Either<Failure, TicketBookingDetailCancellationDomain>>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument) {
    Map<String, dynamic> map = json.decode(fixture(
        "ticket/ticket_booking_cancellation/ticket_booking_cancellation_mock.json"));
    return Future.value(
        Right(TicketBookingDetailCancellationDomain.fromMap(map)));
  }
}

void main() {
  TicketBookingCancellationUseCases? useCases;

  setUpAll(() async {
    useCases = TicketBookingCancellationUseCasesImpl(
      repository: _MockedTicketBookingCancellationUseCase(),
    );
  });

  test('class PublicPromoCodeUseCases If repository == NULL test', () async {
    TicketBookingCancellationUseCases? useCases =
        TicketBookingCancellationUseCasesImpl(repository: null);

    final result = await useCases.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''));

    expect(result?.isLeft, true);
  });

  test('class PublicPromoCodeUseCases If repository != NULL test', () async {
    final result = await useCases!.getTicketCancellationDetail(
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: ''));
    final data = result!.right.getTicketBookingReject?.data;
    expect(data?.refund?.reservationCancellationFee, null);
    expect(data?.refund?.processingFee, null);
    expect(data?.refund?.refundAmount, null);
  });
}
