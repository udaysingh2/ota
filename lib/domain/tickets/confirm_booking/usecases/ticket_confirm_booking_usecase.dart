import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/domain/tickets/confirm_booking/repositories/ticket_confirm_booking_repository.dart';
import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';

/// Interface for TicketReviewReservation use cases.
abstract class TicketConfirmBookingUseCases {
  Future<Either<Failure, TicketConfirmBookingModelDomain>?>
      getTicketConfirmBookingData(ConfirmBookingArgumentDomain argument);
}

class TicketConfirmBookingUseCasesImpl implements TicketConfirmBookingUseCases {
  TicketConfirmBookingRepository? ticketConfirmBookingRepository;

  /// Dependence injection via constructor
  TicketConfirmBookingUseCasesImpl(
      {TicketConfirmBookingRepository? repository}) {
    if (repository == null) {
      ticketConfirmBookingRepository = TicketConfirmBookingRepositoryImpl();
    } else {
      ticketConfirmBookingRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TicketConfirmBookingModelDomain>?>
      getTicketConfirmBookingData(ConfirmBookingArgumentDomain argument) async {
    return await ticketConfirmBookingRepository
        ?.getTicketConfirmBookingData(argument);
  }
}
