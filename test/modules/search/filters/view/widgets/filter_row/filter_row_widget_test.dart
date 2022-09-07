import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/filter_row_widget.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/plus_minus_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Filter Row  Widget", () {
    testWidgets('Filter Row Widget with Minus Button test',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: FilterRowWidget(title: 'Number of Rooms'),
            ),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key(ButtonType.minusButton.toString())));
        await tester.pumpAndSettle();
      });
    });
    testWidgets('Filter Row Widget with Plus Button test',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: FilterRowWidget(title: 'Number of Rooms'),
            ),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key(ButtonType.plusButton.toString())));
        await tester.pumpAndSettle();
      });
    });
  });
}
