import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Ota Alert Dialogue Widget", () {
    testWidgets('Ota Alert Dialogue Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(builder: (context) {
              return Scaffold(
                body: InkWell(
                  onTap: () {
                    const OtaAlertDialog().showAlertDialog(context);
                  },
                ),
              );
            }),
          ),
        );
        await tester.pumpAndSettle();
        await tester.pump();
      });
    });
  });
}
