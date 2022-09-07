import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_range_picker.dart';

import '../../../helper/material_wrapper.dart';

void main() {
  testWidgets('OTA Date Range Picker Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final preSetCheckinDate = DateTime.now().add(const Duration(days: 1));
    final preSetCheckoutDate = DateTime.now().add(const Duration(days: 3));
    Widget widget = getMaterialWrapper(OTADateRangePicker(
      preSetCheckinDate: preSetCheckinDate,
      preSetCheckoutDate: preSetCheckoutDate,
      onSumbit: (checkinDate, checkoutDate) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets('Heart Button Test Making a selection',
      (WidgetTester tester) async {
    // await tester.runAsync(() async {
    // Build our app and trigger a frame.
    final preSetCheckinDate = Helpers.getOnlyDateFromDateTime(
      (DateTime.now().add(const Duration(days: 1))),
    );
    final preSetCheckoutDate = Helpers.getOnlyDateFromDateTime(
      DateTime.now().add(const Duration(days: 2)),
    );

    Widget widget = getMaterialWrapper(OTADateRangePicker(
      preSetCheckinDate: preSetCheckinDate,
      preSetCheckoutDate: preSetCheckoutDate,
      onSumbit: (checkinDate, checkoutDate) {},
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final newDate1 = Helpers.getOnlyDateFromDateTime(
      (DateTime.now().add(const Duration(days: 3))),
    );
    final newDate2 = Helpers.getOnlyDateFromDateTime(
      (DateTime.now().add(const Duration(days: 5))),
    );

    await tester.tap(
      find.byKey(Key(newDate1.toString())),
    );
    await tester.tap(
      find.byKey(const Key('OtaTextButtonTemp')),
    );
    await tester.tap(
      find.byKey(Key(newDate2.toString())),
    );
    await tester.tap(
      find.byKey(const Key('OtaTextButtonTemp')),
    );
    await tester.tap(
      find.byKey(Key(preSetCheckoutDate.toString())),
    );
    await tester.tap(
      find.byKey(Key(preSetCheckinDate.toString())),
    );
  });
  testWidgets('Heart Button Test Win English', (WidgetTester tester) async {
    // await tester.runAsync(() async {
    // Build our app and trigger a frame.
    final preSetCheckinDate = Helpers.getOnlyDateFromDateTime(
      (DateTime.now().add(const Duration(days: 1))),
    );
    final preSetCheckoutDate = Helpers.getOnlyDateFromDateTime(
      DateTime.now().add(const Duration(days: 2)),
    );

    Widget widget = getMaterialWrapper(
      OTADateRangePicker(
        preSetCheckinDate: preSetCheckinDate,
        preSetCheckoutDate: preSetCheckoutDate,
        onSumbit: (checkinDate, checkoutDate) {},
      ),
      languageIndex: 0,
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final newDate1 = Helpers.getOnlyDateFromDateTime(
      (DateTime.now().add(const Duration(days: 3))),
    );
    final newDate2 = Helpers.getOnlyDateFromDateTime(
      (DateTime.now().add(const Duration(days: 5))),
    );

    await tester.tap(
      find.byKey(Key(newDate1.toString())),
    );

    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(Key(newDate2.toString())),
    );
  });
}
