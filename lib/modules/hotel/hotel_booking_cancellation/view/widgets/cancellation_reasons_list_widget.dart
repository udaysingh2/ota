import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_reason_text_field.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kMemberTextCharacterCount = 255;
const _kOtaCancelTextWidgetKey = "OtaTextWidgetKey";

class CancellationReasonsListWidget extends StatelessWidget {
  final OtaRadioOptionListBloc otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final List<String> labelList;
  final Function(int, bool, String) onTap;
  final TextEditingController textEditingController;

  CancellationReasonsListWidget({
    Key? key,
    required this.labelList,
    required this.onTap,
    required this.textEditingController,
  }) : super(key: key);

  Widget _otaTextWidget(
      int index, OtaRadioButtonController controller, BuildContext context) {
    return Column(
      children: [
        OtaRadioButton(
          key: const Key(_kOtaCancelTextWidgetKey),
          verticalPadding: kSize8,
          label: getTranslated(context, labelList[index]),
          isTextFontRegular: true,
          variableCrossAxisAlignment: CrossAxisAlignment.center,
          isSelected: OtaRadioButtonState.selected ==
              controller.state.otaRadioButtonState,
          onClicked: () {
            otaRadioOptionListBloc.unSelect();
            controller.setSelected();
            otaRadioOptionListBloc.setSelected(index, controller);
            onTap(index, _getSelection(index, controller),
                getTranslated(context, labelList[index]));
          },
        ),
        Offstage(
          offstage: index == (labelList.length - 1) &&
                  controller.state.otaRadioButtonState ==
                      OtaRadioButtonState.selected
              ? false
              : true,
          child: Column(
            children: [
              const SizedBox(
                height: kSize16,
              ),
              OtaCancellationTextField(
                textEditingController: textEditingController,
                hintText: getTranslated(
                    context, AppLocalizationsStrings.reasonforcancelation),
                characterCount: _kMemberTextCharacterCount,
                textFormatter: r'[A-Za-z\u0E00-\u0E7F\,. ]',
              ),
              const SizedBox(
                height: kSize16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _getSelection(int index, OtaRadioButtonController controller) {
    if (index != (labelList.length - 1)) {
      return OtaRadioButtonState.selected ==
          controller.state.otaRadioButtonState;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: labelList.length,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final OtaRadioButtonController otaRadioButtonController =
                OtaRadioButtonController();
            return BlocBuilder(
                bloc: otaRadioButtonController,
                builder: () {
                  return _otaTextWidget(
                      index, otaRadioButtonController, context);
                });
          },
        ),
      ],
    );
  }
}
