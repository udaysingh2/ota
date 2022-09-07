import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/preferences/view/widgets/preference_chip_button.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Preference Chip Button Widget Test for isSelected true',
      (tester) async {
    Widget widget = getMaterialWrapper(PreferenceChipButton(
      title: 'test',
      onPressed: () {},
      isSelected: true,
      showShadow: true,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsWidgets);
  });

  testWidgets('Preference Chip Button Widget Test for isSelected false',
      (tester) async {
    Widget widget = getMaterialWrapper(PreferenceChipButton(
      title: 'test',
      onPressed: () {},
      isSelected: false,
      showShadow: true,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsWidgets);
  });
}
