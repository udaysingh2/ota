import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_participant_count_widget.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ticket Participant Count', (tester) async {
    Widget widget = getMaterialWrapper(TicketParticipantCountWidget(
      ticketList: [
        TicketBookingDetailsTicketTypeInfo(
          paxId: "12",
          name: "Bangkok",
          price: 999.0,
          noOfTickets: 2,
        )
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
