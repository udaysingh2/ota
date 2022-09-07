import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/date_picker_widget.dart';

import '../../../../../helper.dart';

void main() {
  DateTime currentDate = DateTime.now();
  testWidgets('OTA Date Picker Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(DatePickerWidget(
      initialDateTime: currentDate,
      maximumDate: currentDate.add(const Duration(days: 3650)),
      minimumDate: currentDate,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
