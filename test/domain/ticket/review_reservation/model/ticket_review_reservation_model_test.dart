import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("ticket/ticket_review_reservation.json");

  TicketReviewReservation ticketReviewReservation =
      TicketReviewReservation.fromJson(jsonString);
  test("Ticket Review Method Domain Model Test", () {
    String stringData = ticketReviewReservation.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = ticketReviewReservation.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Ticket Review Reservation domain model Test", () {
    GetTicketBookingInitiateDetails getTicketBookingInitiate =
        GetTicketBookingInitiateDetails.fromJson(jsonString);
    Map<String, dynamic> map = getTicketBookingInitiate.toMap();

    GetTicketBookingInitiateDetails mapFromModel =
        GetTicketBookingInitiateDetails.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
