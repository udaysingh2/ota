import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';

void main() {
  testWidgets(
    'GradientText test with style',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaTextButton(
            title: 'OTA Text Button',
            fontColor: AppColors.kBorderGrey,
            isSelected: true,
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaTextButton), findsOneWidget);
      expect(find.text('OTA Text Button'), findsOneWidget);
      await tester.tap(find.byType(OtaTextButton));
    },
  );
  testWidgets(
    'GradientText test with style',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaTextButton(
            title: 'OTA Text Button',
            // fontColor: AppColors.kBorderGrey,
            isSelected: false,
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaTextButton), findsOneWidget);
      expect(find.text('OTA Text Button'), findsOneWidget);
      await tester.tap(find.byType(OtaTextButton));
    },
  );
  testWidgets(
    'GradientText test with style and background color',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaTextButton(
            title: 'OTA Text Button',
            backgroundColor: AppColors.kGrey20,
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaTextButton), findsOneWidget);
      expect(find.text('OTA Text Button'), findsOneWidget);
      await tester.tap(find.byType(OtaTextButton));
    },
  );
  testWidgets(
    'GradientText test with style and background color',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OtaTextButton(
            title: 'OTA Text Button',
            isDisabled: true,
            child: Text(
              "OTA Text Button",
            ),
          ),
        ),
      ));
      await tester.pump();
      expect(find.byType(OtaTextButton), findsOneWidget);
      expect(find.text('OTA Text Button'), findsOneWidget);
      await tester.tap(find.byType(OtaTextButton));
    },
  );
}
