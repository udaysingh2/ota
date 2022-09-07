import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view/widgets/ticket_booking_cancellation_policy.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ticket Booking Cancellation Policy Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const TicketBookingCancellationPolicy(
     cancelPolicy: "Booking Cancel after 07-Jun-2019, Otherwise cancellation charge of Full Charge from Grand total will be applied.",
      padding: EdgeInsets.zero,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    await tester.pump();
  });
}