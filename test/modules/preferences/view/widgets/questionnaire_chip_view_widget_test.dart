import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/modules/preferences/view/widgets/preference_chip_button.dart';
import 'package:ota/modules/preferences/view/widgets/questionnaire_chip_view_widget.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  final List<OptionModel> optionsList = [
    OptionModel(
      imageUrl: '',
      isSelected: false,
      optionCode: 'A1',
      optionDesc: '',
    ),
    OptionModel(
      imageUrl: '',
      isSelected: true,
      optionCode: 'A2',
      optionDesc: '',
    )
  ];
  testWidgets('Preference Chip Button List Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(QuestionnaireChipViewWidget(
      otaRadioOptionListBloc: OtaRadioOptionListBloc(),
      optionsModelList: optionsList,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsWidgets);
    await tester.tap(find.byType(PreferenceChipButton).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PreferenceChipButton).at(1));
    await tester.pumpAndSettle();
  });

  testWidgets('Preference Chip Button List Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(QuestionnaireChipViewWidget(
      otaRadioOptionListBloc: OtaRadioOptionListBloc(),
      optionsModelList: optionsList,
      isMultiChoice: false,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsWidgets);
    await tester.tap(find.byType(PreferenceChipButton).first);
    await tester.pumpAndSettle();
  });
}
