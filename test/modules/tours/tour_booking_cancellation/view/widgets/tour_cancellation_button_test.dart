import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view/widgets/tour_cancellation_button.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Cancellation Button Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(const TourCancellationButton(
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