import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/plus_minus_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Ota Increment Decrement Button Widget", () {
    testWidgets('Ota Increment Decrement Button Widget test',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: PlusMinusButton(),
            ),
          ),
        );

        await tester.pumpAndSettle();
      });
    });
  });
}
