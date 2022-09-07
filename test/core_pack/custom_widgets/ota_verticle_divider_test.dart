import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_vertical_divider.dart';

void main() {
  testWidgets(
    'Oval Verticle Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaVerticalDivider(),
        ),
      ));
    },
  );
}
