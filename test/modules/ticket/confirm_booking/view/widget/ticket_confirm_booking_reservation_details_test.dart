import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/confirm_booking/view/widget/ticket_confirm_booking_reservation_details.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ticket Confirm Booking Reservation Details Widget Test',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(TicketConfirmBookingDetailsWidget(
      numberOfDays: "1",
      bookingDate: DateTime.now(),
      contactPerson: "Steve",
      durationText: "6 hours",
      showTravellersInfo: true,
      openTravellersInfo: () {},
      promotionData: const [],
      openWebView: (String url) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
