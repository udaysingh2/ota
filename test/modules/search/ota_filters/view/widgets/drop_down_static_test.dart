import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/drop_down_static.dart';

void main() {
  testWidgets(
    'Drop down static Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: DropDownStatic(
            buttonText: 'buttonText',
          ),
        ),
      ));
    },
  );
}
