import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/star_button.dart';

void main() {
  testWidgets(
    'Star Button Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: StarButton(buttonText: 'buttonText', isSelected: true),
        ),
      ));
    },
  );
}
