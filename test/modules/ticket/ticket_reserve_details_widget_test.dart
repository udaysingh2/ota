import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/tickets/booking_details/view/widget/ticket_reserve_details_widget.dart';

import '../../helper.dart';

void main() {
  testWidgets('Ticket reserve details widget', (tester) async {
    Widget widget = getMaterialWrapper(TicketReserveDetailsWidget(
      packageDate: Helpers().parseDateTime(
        Helpers.getYYYYmmddFromDateTime(
            DateTime.now().add(const Duration(days: 1))),
      ),
      contactName: "MILD MARADENA",
      numberOfDays: "1",
      activityDuration: "4 Hours",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
