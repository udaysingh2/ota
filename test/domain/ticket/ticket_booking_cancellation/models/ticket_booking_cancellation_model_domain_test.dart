import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String jsonStr = fixture(
      "ticket/ticket_booking_cancellation/ticket_booking_cancellation_mock.json");

  TicketBookingDetailCancellationDomain ticketBookingDetailCancellationDomain =
      TicketBookingDetailCancellationDomain.fromJson(jsonStr);

  test("Ticket Booking Detail Cancellation Domain Model Test", () {
    String stringData = ticketBookingDetailCancellationDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = ticketBookingDetailCancellationDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  TicketBookingDetailCancellationDomain modelDomain =
      TicketBookingDetailCancellationDomain.fromJson(jsonStr);

  test("Ticket Booking Detail model Test", () {
    GetTicketBookingReject getTicketBookingReject =
        GetTicketBookingReject.fromJson(jsonStr);
    Map<String, dynamic> map = getTicketBookingReject.toMap();

    GetTicketBookingReject mapFromModel = GetTicketBookingReject.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test('Class TicketBookingDetailCancellationDomain then', () {
    TicketBookingDetailCancellationDomain model = modelDomain;

    expect(
        model.getTicketBookingReject?.data?.refund?.reservationCancellationFee,
        null);

    expect(model.getTicketBookingReject?.data?.refund?.processingFee, null);

    expect(model.getTicketBookingReject?.data?.refund?.refundAmount, null);
  });


}
