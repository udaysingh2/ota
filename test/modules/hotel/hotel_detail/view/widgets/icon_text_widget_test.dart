import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/icon_text_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Icon Text Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const IconTextWidget(
      iconName: "assets/images/icons/price.svg",
      text: "test"
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Row), findsOneWidget);
  });

  testWidgets('Icon Text Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(const IconTextWidget(
      iconName: "assets/images/icons/price.svg",
      text: "test",
      isExpanded: true,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Row), findsOneWidget);
  });
}
