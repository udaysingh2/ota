import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/ota_common/bloc/booking_dropdown.dart';
import 'package:ota/modules/ota_common/widgets/booking_option_list.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  OtaBookingOptionsController controller = OtaBookingOptionsController();
  group("BookingOptionList Widget", () {
    testWidgets('BookingOptionList Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BookingOptionList(
                onTap: () {},
                bookingsOptionsController: controller,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(
          find.byKey(const Key('hotel_key')),
        );
      });
    });
  });
}
