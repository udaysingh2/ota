import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/radio_widget.dart';

import '../../../../../../helper.dart';



void main() {
  testWidgets('Radio widget  ', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(RadioWidget(
      label: "label",
      isSelected: true,
      onClicked: (){},
    )));
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}