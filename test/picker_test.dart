import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_time_picker/widget/picker.dart';

import 'helper/material_wrapper.dart';


void main() {
testWidgets('date picker', (tester) async {
    Widget widget = getMaterialWrapper(CupertinoPicker( scrollController: FixedExtentScrollController(initialItem: DateTime.now().hour),
    itemExtent: 56.0,
    onSelectedItemChanged: (int value) {  },
    children: const [],),);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
