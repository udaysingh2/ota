import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_oval_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Back Button Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const BackNavigationButton(
      width: 1,
      height: 2,
      removeOval: false,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(OtaOvalButton), findsNothing);
  });
  testWidgets('Back Button Test Without Oval', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const BackNavigationButton(
      width: 1,
      height: 2,
      removeOval: true,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(OtaOvalButton), findsNothing);
  });
}
