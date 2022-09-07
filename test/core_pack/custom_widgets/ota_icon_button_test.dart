import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

void main() {
  testWidgets(
    'Icon Button by default',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaIconButton(
            icon: Icon(Icons.check),
          ),
        ),
      ));
    },
  );
  testWidgets(
    'Icon Button with gradient ',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaIconButton(
            icon: Icon(Icons.check, color: AppColors.kGrey10),
            withGradient: true,
          ),
        ),
      ));
    },
  );
  testWidgets(
    'Icon Button with Custom Decoration ',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaIconButton(
            icon: Icon(Icons.check, color: AppColors.kGrey10),
            customDecoration: BoxDecoration(shape: BoxShape.rectangle),
          ),
        ),
      ));
    },
  );
}
