import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/details/data_source/ticket_details_mock_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';

void main() {
  TicketDetailArgumentDomain argument = TicketDetailArgumentDomain(
    cityId: "MA05110041",
    countryId: 'MA05110001',
    ticketId: 'MA05110042',
    ticketDate: '2021-12-26',
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ticket detail mock data source group", () {
    test('Ticket detail mock data source', () async {
      TicketDetailsMockDataSource ticketDetailsMockDataSource =
          TicketDetailsMockDataSource();
      ticketDetailsMockDataSource.getTicketDetails(argument);
      final result =
          await ticketDetailsMockDataSource.getTicketDetails(argument);

      /// Condition check for null value.
      expect(result.getTicketDetails != null, true);
    });
  });
}
