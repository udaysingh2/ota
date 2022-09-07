import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tickets/details/data_source/ticket_details_remote_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';
import 'package:ota/domain/tickets/details/repositories/ticket_details_repository_impl.dart';
import 'package:ota/domain/tickets/details/usecases/ticket_details_usecase.dart';

import '../../../mocks/fixture_reader.dart';

class _TicketDetailsUseCases implements TicketDetailsRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  TicketDetailsRemoteDataSource? ticketDetailsRemoteDataSource;

  @override
  Future<Either<Failure, TicketDetail>> getTicketDetails(
      TicketDetailArgumentDomain argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("ticket/ticket_details/ticket_detail_mock.json"));
    final result = TicketDetail.fromMap(map);
    return Right(result);
  }

  @override
  Future<Either<Failure, TicketDetail>> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("ticket/ticket_details/ticket_detail_mock.json"));
    final result = TicketDetail.fromMap(map);
    return Right(result);
  }
}

void main() {
  TicketDetailArgumentDomain argument = TicketDetailArgumentDomain(
    cityId: "MA05110041",
    countryId: 'MA05110001',
    ticketId: 'MA05110042',
    ticketDate: '2021-12-26',
  );
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ticket details Use case group", () {
    test('Ticket Details Use case', () async {
      TicketDetailsUseCasesImpl();
      TicketDetailsUseCases ticketDetailsUseCases =
          TicketDetailsUseCasesImpl(repository: _TicketDetailsUseCases());
      ticketDetailsUseCases.getTicketDetails(argument);
    });
  });
}
