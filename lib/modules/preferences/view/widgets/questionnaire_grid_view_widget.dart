import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/modules/preferences/view/widgets/preference_card_widget.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';

const int _kGridCrossAxisCount = 2;
const double _kGridItemSpacing = 17.50;

class QuestionnaireGridViewWidget extends StatelessWidget {
  final bool isMultiChoice;
  final Function(int, bool)? onSelected;
  final List<OptionModel> optionsModelList;
  final OtaRadioOptionListBloc otaRadioOptionListBloc;

  const QuestionnaireGridViewWidget({
    Key? key,
    this.isMultiChoice = true,
    this.onSelected,
    required this.optionsModelList,
    required this.otaRadioOptionListBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemWidth =
        MediaQuery.of(context).size.width - ((2 * kSize24) + _kGridItemSpacing);
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final OtaRadioButtonController otaRadioButtonController =
              OtaRadioButtonController();
          if (optionsModelList[index].isSelected) {
            otaRadioButtonController.setSelected();
          }
          return BlocBuilder(
              bloc: otaRadioButtonController,
              builder: () {
                return PreferenceCardWidget(
                  key: Key("preference_card_$index"),
                  width: itemWidth,
                  onClicked: () {
                    if (!isMultiChoice) otaRadioOptionListBloc.unSelect();
                    if (OtaRadioButtonState.selected ==
                        otaRadioButtonController.state.otaRadioButtonState) {
                      otaRadioButtonController.setUnSelected();
                    } else {
                      otaRadioButtonController.setSelected();
                    }
                    otaRadioOptionListBloc.setSelected(
                        index, otaRadioButtonController);
                    if (onSelected != null) {
                      onSelected!(index, otaRadioButtonController.isSelected());
                    }
                  },
                  isSelected: OtaRadioButtonState.selected ==
                      otaRadioButtonController.state.otaRadioButtonState,
                  imageUrl: optionsModelList[index].imageUrl,
                  description: optionsModelList[index].optionDesc,
                );
              });
        },
        childCount: optionsModelList.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _kGridCrossAxisCount,
        crossAxisSpacing: _kGridItemSpacing,
        mainAxisSpacing: _kGridItemSpacing,
      ),
    );
  }
}
