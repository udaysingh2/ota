import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/ota_common/bloc/booking_dropdown.dart';
import 'package:ota/modules/ota_common/widgets/booking_options.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  OtaBookingOptionsController controller = OtaBookingOptionsController();
  group("BookingOptions Widget", () {
    testWidgets('BookingOptions Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BookingOptions(
                otaBookingOptionsController: controller,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
      });
    });
  });
  testWidgets('BookingOptions Widget test', (WidgetTester tester) async {
    controller.toggle();
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookingOptions(
              otaBookingOptionsController: controller,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });
  });
}
