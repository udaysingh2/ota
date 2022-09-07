import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';

void main() {
  testWidgets(
    'OTA button Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OtaChipButton(
              title: "Ota button test",
              isSelected: true,
              onPressed: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OtaChipButton(
              titleWidget: _getTitle(tester),
              title: "Ota button test",
              isSelected: true,
              onPressed: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OtaChipButton(
              title: "Ota button test",
              isSelected: false,
              onPressed: () {},
            ),
          ),
        ),
      );
    },
  );
}

Widget _getTitle(WidgetTester tester) {
  return const Text("Ota training data");
}
