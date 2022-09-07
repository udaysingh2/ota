import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("ticket/ticket_confirm_booking.json");

  TicketConfirmBookingModelDomain ticketConfirmBookingModelDomain =
      TicketConfirmBookingModelDomain.fromJson(jsonString);
  test("Ticket Method Domain Model Test", () {
    String stringData = ticketConfirmBookingModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = ticketConfirmBookingModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket domain model Test", () {
    GetTicketBookingConfirmation getTicketBookingConfirmation =
        GetTicketBookingConfirmation.fromJson(jsonString);
    Map<String, dynamic> map = getTicketBookingConfirmation.toMap();

    GetTicketBookingConfirmation mapFromModel =
        GetTicketBookingConfirmation.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
