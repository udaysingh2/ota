import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_favourite_limit_error.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("OtaFavoriteMaxLimitError Widget", () {
    testWidgets(
        'showErrorDialog dialog test when errorMessage is null,errorTitle is null, btnText is null',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () =>
                      OtaFavoriteMaxLimitError().showErrorDialog(context),
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
    testWidgets('showErrorDialog dialog test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) {
                return TextButton(
                  child: const Text("press"),
                  onPressed: () => OtaFavoriteMaxLimitError().showErrorDialog(
                      context,
                      errorMessage: "",
                      errorTitle: "",
                      btnText: ""),
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
