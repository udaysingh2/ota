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
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_detail_controller.dart';

const int _maxLines = 1;

class PackageGuestUserDetailWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileNumberController;
  final PackageGuestUserDetailController packageGuestUserDetailController;
  final FocusNode guestFirstName;
  final FocusNode guestLastName;
  final FocusNode guestMobileNumber;
  final void Function() onRadioBtnClicked;
  PackageGuestUserDetailWidget({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileNumberController,
    required this.guestFirstName,
    required this.guestLastName,
    required this.guestMobileNumber,
    required this.packageGuestUserDetailController,
    required this.onRadioBtnClicked,
  }) : super(key: key) {
    packageGuestUserDetailController.initializeFunction(
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      mobileNumberController: mobileNumberController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: packageGuestUserDetailController.state.otaRadioButtonBloc!,
        builder: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OtaRadioButton(
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
                    context, AppLocalizationsStrings.reserveForOthers),
                isSelected: packageGuestUserDetailController
                        .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
                    OtaRadioButtonState.selected,
                onClicked: _onRadioClicked,
                horizontalPadding: kSize30,
              ),
              Visibility(
                visible: packageGuestUserDetailController
                        .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
                    OtaRadioButtonState.selected,
                child: Column(
                  children: [
                    const SizedBox(height: kSize16),
                    BlocBuilder(
                        bloc: packageGuestUserDetailController
                            .state.firstNameBloc!,
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
                            state: packageGuestUserDetailController
                                .state.firstNameBloc!.state.otaTextInputState,
                            onClearClick: () {
                              isInvalidFormat
                                  ? firstNameController.clear()
                                  : false;
                            },
                            showCrossIcon: isInvalidFormat ? true : false,
                            onChanged: (_) {
                              packageGuestUserDetailController
                                  .isValidationConfirmed();
                              if (packageGuestUserDetailController
                                  .isFirstNameValid()) {
                                packageGuestUserDetailController
                                    .state.firstNameBloc!
                                    .validInputState();
                              }
                              packageGuestUserDetailController
                                  .updateTextState();
                            },
                          );
                        }),
                    const SizedBox(height: kSize24),
                    BlocBuilder(
                        bloc: packageGuestUserDetailController
                            .state.lastNameBloc!,
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
                            state: packageGuestUserDetailController
                                .state.lastNameBloc!.state.otaTextInputState,
                            textInputFormatter: FormatHelper.getNameFormatter(),
                            onClearClick: () {
                              isInvalidFormat
                                  ? lastNameController.clear()
                                  : false;
                            },
                            showCrossIcon: isInvalidFormat ? true : false,
                            onChanged: (_) {
                              packageGuestUserDetailController
                                  .isValidationConfirmed();
                              if (packageGuestUserDetailController
                                  .isLastNameValid()) {
                                packageGuestUserDetailController
                                    .state.lastNameBloc!
                                    .validInputState();
                              }
                              packageGuestUserDetailController
                                  .updateTextState();
                            },
                          );
                        }),
                    const SizedBox(height: kSize24),
                    BlocBuilder(
                      bloc: packageGuestUserDetailController
                          .state.mobileNumberBloc!,
                      builder: () {
                        bool validFormat =
                            packageGuestUserDetailController.isPhoneValid();
                        return OtaTextInputWidget(
                          focusNode: guestMobileNumber,
                          textEditingController: mobileNumberController,
                          errorLabel: getTranslated(
                            context,
                            AppLocalizationsStrings.mobileNumberRequired,
                          ),
                          label: getTranslated(
                            context,
                            AppLocalizationsStrings.mobileNumberRequired,
                          ),
                          errorText: getTranslated(
                            context,
                            AppLocalizationsStrings.enterValidMobileNumber,
                          ),
                          placeHolder: getTranslated(
                            context,
                            AppLocalizationsStrings.enterMobileNumber,
                          ),
                          state: packageGuestUserDetailController
                              .state.mobileNumberBloc!.state.otaTextInputState,
                          textInputFormatter:
                              FormatHelper.getMobileNumberFormatter(),
                          keyboardType: TextInputType.phone,
                          onClearClick: () {
                            !validFormat
                                ? mobileNumberController.clear()
                                : false;
                          },
                          showCrossIcon: !validFormat ? true : false,
                          onChanged: (_) {
                            packageGuestUserDetailController
                                .isValidationConfirmed();
                            if (packageGuestUserDetailController
                                .isPhoneValid()) {
                              packageGuestUserDetailController
                                  .state.mobileNumberBloc!
                                  .validInputState();
                            }
                            packageGuestUserDetailController.updateTextState();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: kSize20),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void _onRadioClicked() {
    if (packageGuestUserDetailController
            .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
        OtaRadioButtonState.selected) {
      packageGuestUserDetailController.state.otaRadioButtonBloc!.unSelect();
      firstNameController.clear();
      lastNameController.clear();
      mobileNumberController.clear();
      packageGuestUserDetailController.state.firstNameBloc!.validInputState();
      packageGuestUserDetailController.state.lastNameBloc!.validInputState();
      packageGuestUserDetailController.state.mobileNumberBloc!
          .validInputState();
    } else {
      packageGuestUserDetailController.state.otaRadioButtonBloc!.select();
    }
    onRadioBtnClicked();
  }
}
