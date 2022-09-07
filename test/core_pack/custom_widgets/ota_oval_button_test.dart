import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_oval_button.dart';

void main() {
  testWidgets(
    'Oval Button Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaOvalButton(),
        ),
      ));
    },
  );
}
