import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/format_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_controller.dart';

const int _maxLines = 1;

class GuestUserDetailWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final GuestUserDetailController guestUserDetailController;
  final FocusNode guestFirstName;
  final FocusNode guestLastName;
  final void Function() onRadioBtnClicked;
  GuestUserDetailWidget({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.guestUserDetailController,
    required this.guestFirstName,
    required this.guestLastName,
    required this.onRadioBtnClicked,
  }) : super(key: key) {
    guestUserDetailController.initializeFunction(
      firstNameController: firstNameController,
      lastNameController: lastNameController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: guestUserDetailController.state.otaRadioButtonBloc!,
        builder: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OtaRadioButton(
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
                  getTranslated(
                      context, AppLocalizationsStrings.reserveForOther),
                  overflow: TextOverflow.ellipsis,
                  maxLines: _maxLines,
                  style: AppTheme.kBodyRegular,
                ),
                label: getTranslated(
                    context, AppLocalizationsStrings.reserveForOther),
                isSelected: guestUserDetailController
                        .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
                    OtaRadioButtonState.selected,
                onClicked: _onRadioClicked,
                horizontalPadding: kSize30,
              ),
              Offstage(
                offstage: guestUserDetailController
                        .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
                    OtaRadioButtonState.unselected,
                child: Column(
                  children: [
                    const SizedBox(
                      height: kSize14,
                    ),
                    BlocBuilder(
                        bloc: guestUserDetailController.state.firstNameBloc!,
                        builder: () {
                          bool isInvalidFormat = kInvalidNameFormatter
                                  .hasMatch(firstNameController.text)
                              ? true
                              : false;
                          return OtaTextInputWidget(
                            focusNode: guestFirstName,
                            textInputFormatter: FormatHelper.getNameFormatter(),
                            textEditingController: firstNameController,
                            errorLabel: getTranslated(
                              context,
                              AppLocalizationsStrings.reservePersonNameRequired,
                            ),
                            label: getTranslated(
                              context,
                              AppLocalizationsStrings.reservePersonNameRequired,
                            ),
                            errorText: getTranslated(
                              context,
                              AppLocalizationsStrings.reservePersonNameError,
                            ),
                            placeHolder: getTranslated(
                              context,
                              AppLocalizationsStrings.enterName,
                            ),
                            state: guestUserDetailController
                                .state.firstNameBloc!.state.otaTextInputState,
                            onClearClick: () {
                              isInvalidFormat
                                  ? firstNameController.clear()
                                  : false;
                            },
                            showCrossIcon: isInvalidFormat ? true : false,
                            onChanged: (_) {
                              guestUserDetailController.isValidationConfirmed();
                              guestUserDetailController.updateTextState();
                            },
                          );
                        }),
                    const SizedBox(
                      height: kSize24,
                    ),
                    BlocBuilder(
                        bloc: guestUserDetailController.state.lastNameBloc!,
                        builder: () {
                          bool isInvalidFormat = kInvalidNameFormatter
                                  .hasMatch(lastNameController.text)
                              ? true
                              : false;
                          return OtaTextInputWidget(
                            focusNode: guestLastName,
                            textEditingController: lastNameController,
                            errorLabel: getTranslated(
                              context,
                              AppLocalizationsStrings
                                  .reservePersonLastNameRequired,
                            ),
                            label: getTranslated(
                              context,
                              AppLocalizationsStrings
                                  .reservePersonLastNameRequired,
                            ),
                            errorText: getTranslated(
                              context,
                              AppLocalizationsStrings
                                  .reservePersonLastNameError,
                            ),
                            placeHolder: getTranslated(
                              context,
                              AppLocalizationsStrings.enterLastName,
                            ),
                            state: guestUserDetailController
                                .state.lastNameBloc!.state.otaTextInputState,
                            textInputFormatter: FormatHelper.getNameFormatter(),
                            onClearClick: () {
                              isInvalidFormat
                                  ? lastNameController.clear()
                                  : false;
                            },
                            showCrossIcon: isInvalidFormat ? true : false,
                            onChanged: (_) {
                              guestUserDetailController.isValidationConfirmed();
                              guestUserDetailController.updateTextState();
                            },
                          );
                        }),
                    const SizedBox(
                      height: kSize10,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _onRadioClicked() {
    if (guestUserDetailController
            .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
        OtaRadioButtonState.selected) {
      guestUserDetailController.state.otaRadioButtonBloc!.unSelect();
      firstNameController.clear();
      lastNameController.clear();
      guestUserDetailController.state.firstNameBloc!.validInputState();
      guestUserDetailController.state.lastNameBloc!.validInputState();
    } else {
      guestUserDetailController.state.otaRadioButtonBloc!.select();
    }
    onRadioBtnClicked();
  }
}
