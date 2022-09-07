import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/booking_details_widget.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("widgets testing", (tester) async {
    Widget widget = getMaterialWrapper(
      const BookingDetailsWidget(),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
  });

  testWidgets("widgets testing", (tester) async {
    Widget widget = getMaterialWrapper(
      const BookingDetailsWidget(
        isDisabled: true,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
  });
}
