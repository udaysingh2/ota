import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/modules/preferences/view/widgets/preference_chip_button.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';

const double kDividerHeight = 47;
const int _kQuestionInt = 3;
const String _kIconPlaceholder =
    "assets/images/icons/preference_placeholder_image.svg";

const String _kLastQuestionPlaceholder =
    "assets/images/icons/preference_placeholder.svg";

class QuestionnaireChipViewWidget extends StatelessWidget {
  const QuestionnaireChipViewWidget({
    Key? key,
    required this.optionsModelList,
    this.onSelected,
    required this.otaRadioOptionListBloc,
    this.spacing = kSize16,
    this.runSpacing = kSize16,
    this.showShadow = true,
    this.isMultiChoice = true,
    this.imageUrl,
    this.questionNumber,
  }) : super(key: key);
  final Function(int, bool)? onSelected;
  final List<OptionModel> optionsModelList;
  final OtaRadioOptionListBloc otaRadioOptionListBloc;
  final double spacing;
  final double runSpacing;
  final bool showShadow;
  final bool isMultiChoice;
  final String? imageUrl;
  final int? questionNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _getImage(),
          //SvgPicture.asset(imageUrl, height: kSize200),
          const SizedBox(height: kDividerHeight),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: spacing, // gap between adjacent chips
              runSpacing: runSpacing, // gap between lines
              children: optionsModelList.map((e) {
                final OtaRadioButtonController otaRadioButtonController =
                    OtaRadioButtonController();
                if (e.isSelected) otaRadioButtonController.setSelected();
                final index = optionsModelList.indexOf(e);
                return BlocBuilder(
                    bloc: otaRadioButtonController,
                    builder: () {
                      return PreferenceChipButton(
                        key: Key("preference_chip_$index"),
                        title: e.optionDesc,
                        onPressed: () {
                          if (!isMultiChoice) {
                            otaRadioOptionListBloc.unSelect();
                          }
                          if (OtaRadioButtonState.selected ==
                              otaRadioButtonController
                                  .state.otaRadioButtonState) {
                            otaRadioButtonController.setUnSelected();
                          } else {
                            otaRadioButtonController.setSelected();
                            otaRadioOptionListBloc.setSelected(
                                index, otaRadioButtonController);
                          }
                          if (onSelected != null) {
                            onSelected!(
                                index, otaRadioButtonController.isSelected());
                          }
                        },
                        isSelected: OtaRadioButtonState.selected ==
                            otaRadioButtonController.state.otaRadioButtonState,
                        showShadow: showShadow,
                      );
                    });
              }).toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      fit: BoxFit.cover,
      height: kSize200,
      placeholder: (context, url) => _getDefaultImage(),
      errorWidget: (context, url, error) => _getDefaultImage(),
    );
  }

  Widget _getDefaultImage() {
    return SvgPicture.asset(
      questionNumber == _kQuestionInt
          ? _kIconPlaceholder
          : _kLastQuestionPlaceholder,
      fit: BoxFit.cover,
      height: kSize200,
    );
  }
}
