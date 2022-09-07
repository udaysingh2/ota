import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/use_cases/ticket_booking_cancellation_usecases.dart';

import 'package:ota/common/network/failures.dart';
import 'package:either_dart/src/either.dart';

class TicketBookingCancellationSuccessMock
    extends TicketBookingCancellationUseCases {
  @override
  Future<Either<Failure, TicketBookingDetailCancellationDomain>?>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument) async {
    return Right(
      TicketBookingDetailCancellationDomain(
        getTicketBookingReject: GetTicketBookingReject(
          data: Data(
            totalAmount: 1000.0,
            actionStatus: 'success',
            cancellationDate: '06-05-2022',
            refund: Refund(
              processingFee: 100.0,
              reservationCancellationFee: 100.0,
              refundAmount: 800.0,
            ),
          ),
          status: Status(
            code: '1000',
            header: '',
          ),
        ),
      ),
    );
  }
}

class TicketBookingCancellationDataNullMock
    extends TicketBookingCancellationUseCases {
  @override
  Future<Either<Failure, TicketBookingDetailCancellationDomain>?>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument) async {
    return Right(
      TicketBookingDetailCancellationDomain(getTicketBookingReject: null),
    );
  }
}

class TicketBookingCancellationFailureMock
    extends TicketBookingCancellationUseCases {
  @override
  Future<Either<Failure, TicketBookingDetailCancellationDomain>?>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument) async {
    return Left(InternetFailure());
  }
}
