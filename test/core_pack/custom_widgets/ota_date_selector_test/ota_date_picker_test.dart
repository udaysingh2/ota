import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selector/ota_date_picker.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  testWidgets('OTA Date Picker Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final today = DateTime.now();
    final checkinDate = DateTime(today.year, today.month + 1, 1);
    final checkoutDate = DateTime(today.year, today.month + 10, 1);
    final preselectedDates = [
      DateTime(today.year, today.month + 2, 1),
      DateTime(today.year, today.month + 3, 1),
    ];
    final selectedDate = DateTime(today.year, today.month + 6, 1);
    Widget widget = getMaterialWrapper(OTADatePicker(
      checkinDate: checkinDate,
      checkoutDate: checkoutDate,
      onDateChange: (date) {},
      preselectedDates: preselectedDates,
      selectedDate: selectedDate,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(Key(DateTime(today.year, today.month + 6, 5).toString())),
    );
    await tester.tap(
      find.byKey(kOtaDatePickerNextButtonKey),
    );
    await tester.tap(
      find.byKey(kOtaDatePickerPreviousButtonKey),
    );

    // await tester.pumpAndSettle();
  });
}
