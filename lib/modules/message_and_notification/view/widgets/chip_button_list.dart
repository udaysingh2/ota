import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kNotificationIndex = 0;
const int _kReceiptIndex = 1;
const String _specialForYouKey = "specialForYouKey";
const String _newsPromotionKey = "newsPromotionKey";

class MessageAndNotificationChipButton extends StatelessWidget {
  final Function() onNotificationTap;
  final Function() onEReciptsTap;
  final bool readFlag;
  final OtaRadioOptionListBloc otaRadioOptionListBloc;
  final OtaRadioButtonController notificationButtonController =
      OtaRadioButtonController();
  final OtaRadioButtonController receiptButtonController =
      OtaRadioButtonController();
  MessageAndNotificationChipButton({
    Key? key,
    this.readFlag = true,
    required this.onNotificationTap,
    required this.onEReciptsTap,
    required this.otaRadioOptionListBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    notificationButtonController.setSelected();
    return BlocBuilder(
        bloc: otaRadioOptionListBloc,
        builder: () {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: kSize8,
              horizontal: kSize24,
            ),
            child: Row(
              children: [
                BlocBuilder(
                    bloc: notificationButtonController,
                    builder: () {
                      return SizedBox(
                        height: kSize24,
                        child: OtaChipButton(
                          key: const Key(_newsPromotionKey),
                          title: getTranslated(
                              context, AppLocalizationsStrings.newsPromotion),
                          isSelected: OtaRadioButtonState.selected ==
                              notificationButtonController
                                  .state.otaRadioButtonState,
                          isGreybackground: true,
                          isLighterGreyColor: true,
                          onPressed: () {
                            receiptButtonController.setUnSelected();
                            otaRadioOptionListBloc.unSelect();
                            notificationButtonController.setSelected();
                            otaRadioOptionListBloc.setSelected(
                                _kNotificationIndex,
                                notificationButtonController);
                            onNotificationTap();
                          },
                        ),
                      );
                    }),
                const SizedBox(
                  width: kSize8,
                ),
                BlocBuilder(
                    bloc: receiptButtonController,
                    builder: () {
                      return SizedBox(
                        height: kSize24,
                        child: OtaChipButton(
                          key: const Key(_specialForYouKey),
                          title: getTranslated(
                              context, AppLocalizationsStrings.specialForYou),
                          isSelected: OtaRadioButtonState.selected ==
                              receiptButtonController.state.otaRadioButtonState,
                          isGreybackground: true,
                          isLighterGreyColor: true,
                          onPressed: () {
                            notificationButtonController.setUnSelected();
                            otaRadioOptionListBloc.unSelect();
                            receiptButtonController.setSelected();
                            otaRadioOptionListBloc.setSelected(
                                _kReceiptIndex, receiptButtonController);
                            onEReciptsTap();
                          },
                        ),
                      );
                    })
              ],
            ),
          );
        });
  }
}
