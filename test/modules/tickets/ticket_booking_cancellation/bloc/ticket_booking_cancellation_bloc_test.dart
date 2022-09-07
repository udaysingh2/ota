import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/bloc/ticket_booking_cancellation_bloc.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_view_model.dart';

import 'mocks/ticket_booking_cancellation_mocks.dart';

void main() {
  TicketBookingCancellationArgumentDomain argumentDomain =
      TicketBookingCancellationArgumentDomain(
          confirmationNo: 'TR220302-AA-0005', cancellationReason: '');
  TicketBookingCancellationArgument argument =
      TicketBookingCancellationArgument(
          confirmNo: 'TR220302-AA-0005', reason: '');
  TicketBookingCancellationBloc bloc = TicketBookingCancellationBloc();
  TicketBookingCancellationSuccessMock successMock =
      TicketBookingCancellationSuccessMock();
  TicketBookingCancellationDataNullMock nullMock =
      TicketBookingCancellationDataNullMock();
  TicketBookingCancellationFailureMock failureMock =
      TicketBookingCancellationFailureMock();

  group(
      'For class TicketBookingCancellationBloc ==> getTicketBookingCancellationData',
      () {
    test('For class TourBookingCancellationBloc ==> initDefaultValue', () {
      final actual = bloc.initDefaultValue();

      expect(actual.state, TicketBookingCancellationScreenStates.initial);
    });

    test('For class TicketBookingCancellationBloc ==> If Argument Null',
        () async {
      bloc.ticketBookingCancellationUseCases = successMock;

      await bloc.getTicketBookingCancellationData(null);

      expect(bloc.state.state, TicketBookingCancellationScreenStates.failure);
    });

    test('For class TicketBookingCancellationBloc ==> If Data Null', () async {
      bloc.ticketBookingCancellationUseCases = nullMock;

      await bloc.getTicketBookingCancellationData(argument);

      Either<Failure, TicketBookingDetailCancellationDomain?>? result =
          await nullMock.getTicketCancellationDetail(argumentDomain);

      expect(result?.isRight, true);
      expect(result?.right?.getTicketBookingReject == null, true);
    });

    test('For class TicketBookingCancellationBloc ==> If All TRUE Then',
        () async {
      bloc.ticketBookingCancellationUseCases = successMock;

      await bloc.getTicketBookingCancellationData(argument);

      Either<Failure, TicketBookingDetailCancellationDomain?>? result =
          await successMock.getTicketCancellationDetail(argumentDomain);

      expect(result?.isRight, true);
      expect(
          result?.right?.getTicketBookingReject?.data?.actionStatus?.isNotEmpty,
          true);
    });

    test('For class TicketBookingCancellationBloc ==> If Failure Then',
        () async {
      bloc.ticketBookingCancellationUseCases = failureMock;

      await bloc.getTicketBookingCancellationData(argument);

      Either<Failure, TicketBookingDetailCancellationDomain?>? result =
          await failureMock.getTicketCancellationDetail(argumentDomain);

      expect(result?.isLeft, true);
    });
  });
}
