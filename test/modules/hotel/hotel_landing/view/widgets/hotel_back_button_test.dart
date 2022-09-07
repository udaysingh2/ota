import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_back_button.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Back Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const HotelLandingBackNavigationButton(
      width: 10,
      height: 20,
      removeOval: false,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Material), findsWidgets);
    await tester.pump();
  });

  testWidgets('Hotel Back Button Test with remove oval true',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const HotelLandingBackNavigationButton(
      width: 10,
      height: 20,
      removeOval: true,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Material), findsWidgets);
    await tester.pump();
  });
}
