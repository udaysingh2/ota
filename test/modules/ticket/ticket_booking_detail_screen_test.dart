import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ticket Booking Detail Screen', (tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapperWithArguments(
          const Scaffold(),
          AppRoutes.ticketBookingDetailScreen,
          TicketBookingDetailArgument(
              bookingUrn: 'AHSHDGDGD',
              bookingType: 'Ticket',
              bookingId: 'DGTDGDGDGD'));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
