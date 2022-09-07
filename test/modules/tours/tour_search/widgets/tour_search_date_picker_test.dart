import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/modules/tours/tour_search/results/view/widgets/tour_search_date_picker.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Search date Picker', (tester) async {
    Widget widget = getMaterialWrapper(TourSearchDatePicker(
      onReset: () {},
      onSubmit: (dateTime) {},
      selectedDate: DateTime.now(),
      titleKey: "title",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(OtaTextButton).first);
    await tester.pump();
    await tester.pumpAndSettle();
  });
}