import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_tile_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Filter Tile Widget", () {
    testWidgets('Filter Tile Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: FilterTileWidget(
                childAgeList: [11, 8],
                roomNumber: 2,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
      });
    });
  });
}
