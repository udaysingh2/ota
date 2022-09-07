import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_back_button.dart';

void main() {
  testWidgets(
    'Icon Button with gradient ',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OtaBackButton(
            isWhite: true,
            onPress: () {},
          ),
        ),
      ));
    },
  );
  testWidgets(
    'Icon Button with Custom Decoration ',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: OtaBackButton(
          isWhite: false,
          onPress: () {},
        )),
      ));
    },
  );
}
