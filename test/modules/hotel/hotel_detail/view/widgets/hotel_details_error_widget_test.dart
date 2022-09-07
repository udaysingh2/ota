import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_detail_error_widget.dart';

void method() {
  printDebug('test');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Detail Error Widget", () {
    testWidgets('Hotel Detail Error Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: HotelDetailErrorWidget(
                height: 300,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
      });
    });
  });
}