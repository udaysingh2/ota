import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/repositories/ticket_booking_cancellation_repository_impl.dart';

/// Interface for TicketDetail use cases.
abstract class TicketBookingCancellationUseCases {
  Future<Either<Failure, TicketBookingDetailCancellationDomain>?>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument);
}

class TicketBookingCancellationUseCasesImpl
    implements TicketBookingCancellationUseCases {
  TicketBookingCancellationRepository? ticketBookingCancellationRepository;

  /// Dependence injection via constructor
  TicketBookingCancellationUseCasesImpl(
      {TicketBookingCancellationRepository? repository}) {
    if (repository == null) {
      ticketBookingCancellationRepository =
          TicketBookingCancellationRepositoryImpl();
    } else {
      ticketBookingCancellationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TicketBookingDetailCancellationDomain>?>
      getTicketCancellationDetail(
          TicketBookingCancellationArgumentDomain argument) async {
    return await ticketBookingCancellationRepository
        ?.getTicketCancellationDetail(argument);
  }
}
