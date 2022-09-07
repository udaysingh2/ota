import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_back_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_webview_bottom_sheet.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Ota WebView Modal Bottom Sheet', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () =>
                    const OtaWebViewBottomSheet().showBottomSheet(context),
              );
            }),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"), warnIfMissed: false);
      await tester.pump();
      await tester.tap(find.byType(OtaBackButton));
      await tester.pump();
      await tester.pumpAndSettle();
    });
  });
}
