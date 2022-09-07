import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/ota_greeting_text_widget.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('ota greeting text widget ...', (tester) async {
    Widget widget = getMaterialWrapper((const GreetingTextWidget()));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Column), findsOneWidget);
  });
}
