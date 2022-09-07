import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_booking_info.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';
import '../../helper.dart';

void main() {
  testWidgets('Ticket Booking Info', (tester) async {
    Widget widget = getMaterialWrapper(TicketBookingInfo(
      ticketType: [
        TicketBookingDetailsTicketTypeInfo(
            name: 'ticket', paxId: "paxid", noOfTickets: 1, price: 100.11)
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
