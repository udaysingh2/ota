import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/radio_widget_list.dart';

import '../../../../../../helper.dart';

void main() {
  testWidgets('Radio widget List', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(RadioWidgetList(
      labelList: const ["label1", "label2"],
      selectedIndexOption: 1,
      onPressed: (int int) {},
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
