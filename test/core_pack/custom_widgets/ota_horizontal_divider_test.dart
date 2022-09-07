import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';

void main() {
  testWidgets(
    'Oval Horizontal Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaHorizontalDivider(),
        ),
      ));
    },
  );
}
