import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/accomodation_widget.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Accomodation Widget", () {
    testWidgets('Review Widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AccommodationWidget(
                address:
                    "122/8 ซอยบ้านใหม่สามัคคี 14 หมู่ 6 อ.เมือง จ. เชียงใหม่  50100",
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(
            find.text(
                '122/8 ซอยบ้านใหม่สามัคคี 14 หมู่ 6 อ.เมือง จ. เชียงใหม่  50100'),
            findsOneWidget);
        await tester.pumpAndSettle();
      });
    });
  });
}
