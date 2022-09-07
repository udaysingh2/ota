import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';

void main() {
  testWidgets(
    'GradientText test with style',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaBottomButtonBar(
            button1: OtaTextButton(
              title: "OTA Bottom Button Bar",
            ),
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaBottomButtonBar), findsOneWidget);
      await tester.tap(find.byType(OtaBottomButtonBar));
    },
  );
  testWidgets(
    'GradientText test with style where button 2 is not null',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaBottomButtonBar(
            button1: OtaTextButton(
              title: "Button 1",
            ),
            button2: OtaTextButton(
              title: "Button 2",
            ),
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaBottomButtonBar), findsOneWidget);
      await tester.tap(find.byType(OtaBottomButtonBar));
    },
  );
}
