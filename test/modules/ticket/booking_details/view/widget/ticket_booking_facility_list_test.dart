import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_booking_facility_list.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_details_view_model.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("Ticket Booking Facility testing", (tester) async {
    Widget widget = getMaterialWrapper(
      TicketBookingFacilityList(
        facilityMap: [
          TicketBookingDetailsHighlight(key: "key", value: "value")
        ],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
