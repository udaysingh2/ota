import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/share_button.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Share Button Remove Oval True Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      const ShareButton(removeOval: true),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Material), findsNWidgets(2));
  });

  testWidgets('Share Button Remove Oval False Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      const ShareButton(removeOval: false),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Material), findsNWidgets(2));
  });
}
