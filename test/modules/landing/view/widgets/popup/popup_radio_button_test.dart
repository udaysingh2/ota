import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_radio_button.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("widgets testing", (tester) async {
    Widget widget = getMaterialWrapper(
      const PopUpRadioButton(
        label: "",
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets("widgets testing", (tester) async {
    Widget widget = getMaterialWrapper(
      const PopUpRadioButton(
        label: "",
        isSelected: true,
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
