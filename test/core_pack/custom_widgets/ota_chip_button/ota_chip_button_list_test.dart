import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button_list.dart';

void main() {
  testWidgets(
    'ota radio list test',
    (WidgetTester tester) async {
      // given selected state
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OtaChipButtonList(
              labelList: const ['object 1'],
              onTap: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("otaChipButton")).first);
      await tester.pumpAndSettle();
    },
  );
}
