import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/search_text_widget.dart';

import '../../../../helper.dart';

void main() {
  testWidgets('Share Button Remove Oval True Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      const SearchTextWidget(
        searchCustomText: "123",
        maxWidth: 100,
        color: Colors.red,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
  });
}
