import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/preferences/view/widgets/preference_card_widget.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  group('Preference Card Widget Test', () {
    testWidgets('isSelected true', (tester) async {
      Widget widget = getMaterialWrapper(PreferenceCardWidget(
        onClicked: () {},
        width: 140,
        description: "description",
        isSelected: true,
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });

    testWidgets('isSelected false', (tester) async {
      Widget widget = getMaterialWrapper(PreferenceCardWidget(
        onClicked: () {},
        width: 140,
        description: "description",
        isSelected: false,
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
