import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view/widgets/ticket_cancellation_button.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ticket Cancellation Button Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const TicketCancellationButton(
      title: "title",
      isDisabled: false,
      isSelected: true,
      buttonURL: "buttonURL",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsOneWidget);
    await tester.pump();
  });
}