import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/tickets/details/data_source/ticket_details_mock_data_source.dart';
import 'package:ota/domain/tickets/details/data_source/ticket_details_remote_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';
import 'package:ota/domain/tickets/details/repositories/ticket_details_repository_impl.dart';

import '../../../modules/hotel/repositories/Internet_failure_mock.dart';
import '../../../modules/hotel/repositories/Internet_success_mock.dart';

class TicketDetailsDataSourceFailureMock
    implements TicketDetailsRemoteDataSource {
  @override
  Future<TicketDetail> getTicketDetails(TicketDetailArgumentDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<TicketDetail> getTicketPackageDetails(
      TicketPackageDetailsArgumentDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  TicketDetailsRepository? ticketDetailsRepositoryMock;
  TicketDetailsRepository? ticketDetailsRepositoryInternetFailure;
  TicketDetailsRepository? ticketDetailsRepositoryServerException;

  TicketDetailArgumentDomain argument = TicketDetailArgumentDomain(
    cityId: "MA05110041",
    countryId: 'MA05110001',
    ticketId: 'MA05110042',
    ticketDate: '2021-12-26',
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    ticketDetailsRepositoryMock = TicketDetailsRepositoryImpl();

    /// Code coverage for mock class
    ticketDetailsRepositoryMock = TicketDetailsRepositoryImpl(
        remoteDtaSource: TicketDetailsMockDataSource(),
        internetConnection: InternetSuccessMock());

    ticketDetailsRepositoryServerException = TicketDetailsRepositoryImpl(
        remoteDtaSource: TicketDetailsDataSourceFailureMock(),
        internetConnection: InternetSuccessMock());

    /// Coverage in-case of internet failure
    ticketDetailsRepositoryInternetFailure = TicketDetailsRepositoryImpl(
        remoteDtaSource: TicketDetailsDataSourceFailureMock(),
        internetConnection: InternetFailureMock());
  });

  test(
      'Ticket details Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result =
        await ticketDetailsRepositoryMock!.getTicketDetails(argument);

    /// Get model from mock data.
    final TicketDetail detail = result.right;

    /// Condition check for booking data value null
    expect(detail.getTicketDetails != null, true);
  });

  test(
      'Ticket details Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await ticketDetailsRepositoryInternetFailure!
        .getTicketDetails(argument);

    expect(result.isLeft, true);
  });

  test(
      'Ticket details Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await ticketDetailsRepositoryServerException!
        .getTicketDetails(argument);

    expect(result.isLeft, true);
  });
}
