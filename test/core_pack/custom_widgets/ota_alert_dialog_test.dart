import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Ota alert dialog widget", () {
    testWidgets('Ota alert dialog test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => const OtaAlertDialog().showAlertDialog(context),
                );
              }),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });
  });
}
