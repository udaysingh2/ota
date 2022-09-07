import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selection_widget.dart';

void main() {
  testWidgets('ota date selection widget ...', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OtaDateSelectionWidget(
              selectedDate: '13-12-2021',
              changeDate: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });
  });
}
