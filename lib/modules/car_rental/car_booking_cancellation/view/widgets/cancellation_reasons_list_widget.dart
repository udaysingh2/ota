import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_reason_text_field.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMemberTextCharacterCount = 255;
const String _kOtaCancelTextWidgetKey = "otaTextWidgetKey";
const String _textFormatter = r'[A-Za-z\u0E00-\u0E7F0-9 ]';

class CancellationReasonsListWidget extends StatelessWidget {
  final OtaRadioOptionListBloc otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final List<String> labelList;
  final Function(int, bool, String) onTap;
  final TextEditingController textEditingController;
  final FocusNode othersFocus;

  CancellationReasonsListWidget({
    Key? key,
    required this.labelList,
    required this.onTap,
    required this.textEditingController,
    required this.othersFocus,
  }) : super(key: key);

  Widget _otaRadioButtonList(int index,
      OtaRadioButtonController otaRadioButtonController, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSize16),
          child: OtaRadioButton(
            key: const Key(_kOtaCancelTextWidgetKey),
            onClicked: () {
              otaRadioOptionListBloc.unSelect();
              otaRadioButtonController.setSelected();
              otaRadioOptionListBloc.setSelected(
                  index, otaRadioButtonController);
              onTap(index, _getSelection(index, otaRadioButtonController),
                  getTranslated(context, labelList[index]));
              othersFocus.unfocus();
            },
            horizontalPadding: kSize0,
            verticalPadding: kSize5,
            isCenteredAlign: true,
            unSelectedWidget: Ink(
              height: kSize20,
              width: kSize20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.kPurpleOutline,
                ),
              ),
            ),
            textWidget: Text(
              getTranslated(context, labelList[index]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTheme.kBodyRegular,
            ),
            label:
                getTranslated(context, AppLocalizationsStrings.reserveForOther),
            isSelected: OtaRadioButtonState.selected ==
                otaRadioButtonController.state.otaRadioButtonState,
          ),
        ),
        if (index == (labelList.length - 1) &&
            otaRadioButtonController.state.otaRadioButtonState ==
                OtaRadioButtonState.selected)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: OtaCancellationTextField(
              focusNode: othersFocus,
              boxMargin: kSize0,
              textEditingController: textEditingController,
              hintText: getTranslated(
                  context, AppLocalizationsStrings.carSpecifyReason),
              characterCount: _kMemberTextCharacterCount,
              textFormatter: _textFormatter,
            ),
          ),
      ],
    );
  }

  bool _getSelection(int index, OtaRadioButtonController controller) {
    if (index != (labelList.length - 1)) {
      return OtaRadioButtonState.selected ==
          controller.state.otaRadioButtonState;
    } else if (textEditingController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: labelList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final OtaRadioButtonController otaRadioButtonController =
            OtaRadioButtonController();
        return BlocBuilder(
          bloc: otaRadioButtonController,
          builder: () {
            return _otaRadioButtonList(
              index,
              otaRadioButtonController,
              context,
            );
          },
        );
      },
    );
  }
}
