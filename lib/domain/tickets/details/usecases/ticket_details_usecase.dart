import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';
import 'package:ota/domain/tickets/details/repositories/ticket_details_repository_impl.dart';

abstract class TicketDetailsUseCases {
  Future<Either<Failure, TicketDetail>?> getTicketDetails(
      TicketDetailArgumentDomain argument);

  Future<Either<Failure, TicketDetail>?> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument);
}

class TicketDetailsUseCasesImpl implements TicketDetailsUseCases {
  TicketDetailsRepository? ticketDetailsRepository;

  TicketDetailsUseCasesImpl({TicketDetailsRepository? repository}) {
    if (repository == null) {
      ticketDetailsRepository = TicketDetailsRepositoryImpl();
    } else {
      ticketDetailsRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TicketDetail>?> getTicketDetails(
      TicketDetailArgumentDomain argument) async {
    return await ticketDetailsRepository?.getTicketDetails(argument);
  }

  @override
  Future<Either<Failure, TicketDetail>?> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument) async {
    return await ticketDetailsRepository?.getTicketPackageDetails(argument);
  }
}
