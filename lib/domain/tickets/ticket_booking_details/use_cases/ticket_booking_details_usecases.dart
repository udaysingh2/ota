import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_argument_model.dart';
import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';
import 'package:ota/domain/tickets/ticket_booking_details/repositories/ticket_booking_details_repository_impl.dart';

/// Interface for TicketDetail use cases.
abstract class TicketBookingDetailUseCases {
  Future<Either<Failure, TicketBookingDetailModelDomain>?> getBookingTicketDetail(
      TicketBookingDetailArgumentDomain argument);
}

class TicketBookingDetailUseCasesImpl implements TicketBookingDetailUseCases {
  TicketBookingDetailRepository? ticketBookingDetailRepository;

  /// Dependence injection via constructor
  TicketBookingDetailUseCasesImpl({TicketBookingDetailRepository? repository}) {
    if (repository == null) {
      ticketBookingDetailRepository = TicketBookingDetailRepositoryImpl();
    } else {
      ticketBookingDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TicketBookingDetailModelDomain>?> getBookingTicketDetail(
      TicketBookingDetailArgumentDomain argument) async{
    return await ticketBookingDetailRepository?.getTicketBookingDetail(argument);
  }
}
