import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view/widgets/cancellation_button.dart';

void main() {
  group("cancellation button widget", () {
    testWidgets('cancellation button widget', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CancellationButton(
          title: "",
          isDisabled: true,
        )),
      ));
      await tester.pumpAndSettle();
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
            body: CancellationButton(
          title: "",
          isDisabled: false,
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
