import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view/widgets/cancellation_reasons_list_widget.dart';

void main() {
  TextEditingController textEditingController = TextEditingController();
  group("Cancellation reason list test", () {
    testWidgets('Contact information page', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CancellationReasonsListWidget(
            textEditingController: textEditingController,
            onTap: (integer, boolean, string) {},
            labelList: const ["object", "object2", "object3"],
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("OtaTextWidgetKey")).first);
      await tester.pumpAndSettle();
    });
  });
}
