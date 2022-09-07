import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_argument_domain.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';
import 'package:ota/domain/tickets/review_reservation/repositories/ticket_review_reservation_repository_impl.dart';

/// Interface for TicketReviewReservation use cases.
abstract class TicketReviewReservationUseCases {
  Future<Either<Failure, TicketReviewReservation>?>
      getTicketReviewReservationData(
          TicketReviewReservationArgumentDomain argument);
}

class TicketReviewReservationUseCasesImpl
    implements TicketReviewReservationUseCases {
  TicketsReviewReservationRepository? ticketReviewReservationRepository;

  /// Dependence injection via constructor
  TicketReviewReservationUseCasesImpl(
      {TicketsReviewReservationRepository? repository}) {
    if (repository == null) {
      ticketReviewReservationRepository =
          TicketsReviewReservationRepositoryImpl();
    } else {
      ticketReviewReservationRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TicketReviewReservation>?>
      getTicketReviewReservationData(
          TicketReviewReservationArgumentDomain argument) async {
    return await ticketReviewReservationRepository
        ?.getTicketReviewReservationData(argument);
  }
}
