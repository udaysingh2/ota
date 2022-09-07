import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/scb_alert_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("SCB alert dialog widget", () {
    testWidgets('SCB alert dialog test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => SCBAlertDialog().showAlertDialog(context),
                );
              }),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaChipButton).first);
        await tester.pumpAndSettle();
      });
    });

    testWidgets('SCB alert dialog test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => SCBAlertDialog().showAlertDialog(context),
                );
              }),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaChipButton).last);
        await tester.pumpAndSettle();
      });
    });
  });
}
