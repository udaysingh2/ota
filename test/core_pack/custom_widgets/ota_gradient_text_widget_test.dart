import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';

void main() {
  testWidgets(
    'Text Button with gradient ',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaGradientText(),
        ),
      ));
    },
  );
}
