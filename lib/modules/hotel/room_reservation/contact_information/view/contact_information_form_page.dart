import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/bloc/check_validation_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/bloc/contact_information_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/format_helper.dart';

const int _kMaxLines = 2;
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kCheckGradient = "assets/images/icons/checkbox_gradient.svg";

class ContactInformationFormPage extends StatefulWidget {
  const ContactInformationFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactInformationFormPage> createState() =>
      _ContactInformationFormPageState();
}

class _ContactInformationFormPageState
    extends State<ContactInformationFormPage> {
  ContactInformationArgumentModel? argumentModel;
  ContactInformationBloc contactInformationBloc = ContactInformationBloc();
  late OtaRadioButtonBloc otaRadioButtonBloc = OtaRadioButtonBloc();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  FocusNode focusNodeFirstName = FocusNode();
  FocusNode focusNodeLastName = FocusNode();
  CheckValidationBloc checkValidationBloc = CheckValidationBloc();

  bool showMaterialBanner = false;

  @override
  void initState() {
    super.initState();

    focusNodeFirstName.addListener(() {
      if (!focusNodeFirstName.hasFocus) {
        contactInformationBloc.checkValidation();
        contactInformationBloc.updateTextState();
      }
    });

    focusNodeLastName.addListener(() {
      if (!focusNodeLastName.hasFocus) {
        contactInformationBloc.checkValidation();
        contactInformationBloc.updateTextState();
      }
    });

    firstNameController.addListener(() {
      contactInformationBloc.state.initialContactInformationArgumentData
          .firstName = firstNameController.text;
      checkValidationBloc.reload();
    });
    lastNameController.addListener(() {
      contactInformationBloc.state.initialContactInformationArgumentData
          .lastName = lastNameController.text;
      checkValidationBloc.reload();
    });
    contactInformationBloc.stream.first.then((value) {
      if (contactInformationBloc.state.initialContactInformationArgumentData
          .contactInformationSelected) {
        otaRadioButtonBloc.select();
      } else {
        otaRadioButtonBloc.unSelect();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFromArgument();
      contactInformationBloc.checkValidation();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    otaRadioButtonBloc.dispose();
    contactInformationBloc.dispose();
  }

  void loadFromArgument() {
    argumentModel = ModalRoute.of(context)?.settings.arguments
        as ContactInformationArgumentModel;
    if (argumentModel != null) {
      contactInformationBloc.mapFromArgument(argumentModel!);
    }
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: BlocBuilder(
        bloc: contactInformationBloc,
        builder: () {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildAppBar(context),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kSize32, vertical: kSize16),
                            child: Column(
                              children: [
                                Text(
                                  getTranslated(context,
                                      AppLocalizationsStrings.informationText1),
                                  style: AppTheme.kSmallRegular
                                      .copyWith(color: AppColors.kSecondary),
                                  maxLines: _kMaxLines,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: kSize16),
                                Text(
                                  getTranslated(context,
                                      AppLocalizationsStrings.informationText2),
                                  style: AppTheme.kSmallRegular
                                      .copyWith(color: AppColors.kGrey50),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: kSize17),
                                _buildFirstNameTextWidget(context),
                                const SizedBox(height: kSize19),
                                _buildLastNameTextWidget(context),
                                const SizedBox(height: kSize19),
                                _buildEmailTextWidget(context),
                                const SizedBox(height: kSize19),
                                _buildPhoneNumberTextWidget(),
                                const SizedBox(height: kSize26),
                                _buildSaveInformationButton(context),
                                const SizedBox(height: kSize51),
                                Text(
                                  getTranslated(context,
                                      AppLocalizationsStrings.informationText3),
                                  textAlign: TextAlign.center,
                                  style: AppTheme.kSmallRegular
                                      .copyWith(color: AppColors.kGrey50),
                                ),
                                const SizedBox(height: kSize38),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _buildSubmitButton(context),
                    ],
                  ),
                  BlocBuilder(
                    bloc: contactInformationBloc,
                    builder: () {
                      if (contactInformationBloc
                              .state.submitCustomerDetailsState ==
                          SubmitCustomerDetailsState.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BlocBuilder _buildSaveInformationButton(BuildContext context) {
    return BlocBuilder(
      bloc: otaRadioButtonBloc,
      builder: () {
        return Align(
          alignment: Alignment.centerLeft,
          child: OtaRadioButton(
            label: getTranslated(
                context, AppLocalizationsStrings.informationText3),
            textWidget: Text(
              getTranslated(context, AppLocalizationsStrings.checkBoxText),
              style: AppTheme.kBodyRegular,
              textAlign: TextAlign.left,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
            horizontalPadding: kSize0,
            verticalPadding: kSize0,
            circledRadio: true,
            selectedWidget: SvgPicture.asset(_kCheckGradient,
                width: kSize20, height: kSize20),
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
            onClicked: () {
              if (otaRadioButtonBloc.state.otaRadioButtonState ==
                  OtaRadioButtonState.selected) {
                otaRadioButtonBloc.unSelect();
                contactInformationBloc
                    .state
                    .initialContactInformationArgumentData
                    .contactInformationSelected = false;
              } else {
                otaRadioButtonBloc.select();
                contactInformationBloc
                    .state
                    .initialContactInformationArgumentData
                    .contactInformationSelected = true;
              }
            },
            isSelected: otaRadioButtonBloc.state.otaRadioButtonState ==
                OtaRadioButtonState.selected,
          ),
        );
      },
    );
  }

  OtaTextInputWidget _buildPhoneNumberTextWidget() {
    return OtaTextInputWidget(
      textInputFormatter: FormatHelper.getInputFormatter(),
      isEnabled: false,
      label: getTranslated(context, AppLocalizationsStrings.mobileNumber),
      placeHolder: contactInformationBloc
          .state.initialContactInformationArgumentData.phoneNumber,
      padding: EdgeInsets.zero,
    );
  }

  OtaTextInputWidget _buildEmailTextWidget(BuildContext context) {
    return OtaTextInputWidget(
      textInputFormatter: FormatHelper.getInputFormatter(),
      isEnabled: false,
      label: getTranslated(context, AppLocalizationsStrings.email),
      placeHolder: contactInformationBloc
          .state.initialContactInformationArgumentData.email,
      padding: EdgeInsets.zero,
    );
  }

  BlocBuilder _buildLastNameTextWidget(BuildContext context) {
    return BlocBuilder(
        bloc: contactInformationBloc.state.lastNameBloc!,
        builder: () {
          bool isNotInFormat = kInvalidNameFormatter.hasMatch(
                  contactInformationBloc
                      .state.initialContactInformationArgumentData.lastName!)
              ? true
              : false;
          return OtaTextInputWidget(
            focusNode: focusNodeLastName,
            errorLabel:
                getTranslated(context, AppLocalizationsStrings.lastName),
            errorText: getTranslated(
                context, AppLocalizationsStrings.lastNameErrorText),
            state: contactInformationBloc
                .state.lastNameBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getNameFormatter(),
            textEditingController: contactInformationBloc
                        .state.initialContactInformationArgumentData.lastName !=
                    null
                ? (lastNameController
                  ..text = contactInformationBloc.state
                          .initialContactInformationArgumentData.lastName ??
                      "")
                : lastNameController,
            label: getTranslated(context, AppLocalizationsStrings.lastName),
            placeHolder:
                getTranslated(context, AppLocalizationsStrings.enterLastName),
            padding: EdgeInsets.zero,
            onClearClick: () {
              isNotInFormat ? lastNameController.clear() : false;
            },
            showCrossIcon: isNotInFormat ? true : false,
          );
        });
  }

  BlocBuilder _buildFirstNameTextWidget(BuildContext context) {
    return BlocBuilder(
        bloc: contactInformationBloc.state.firstNameBloc!,
        builder: () {
          bool isNotInFormat = kInvalidNameFormatter.hasMatch(
                  contactInformationBloc
                      .state.initialContactInformationArgumentData.firstName)
              ? true
              : false;
          return OtaTextInputWidget(
            focusNode: focusNodeFirstName,
            errorLabel: getTranslated(context, AppLocalizationsStrings.name),
            errorText: getTranslated(
                context, AppLocalizationsStrings.firstNameErrorText),
            state: contactInformationBloc
                .state.firstNameBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getNameFormatter(),
            textEditingController: contactInformationBloc.state
                    .initialContactInformationArgumentData.firstName.isNotEmpty
                ? (firstNameController
                  ..text = contactInformationBloc
                      .state.initialContactInformationArgumentData.firstName)
                : firstNameController,
            label: getTranslated(context, AppLocalizationsStrings.name),
            placeHolder:
                getTranslated(context, AppLocalizationsStrings.enterName),
            padding: EdgeInsets.zero,
            onClearClick: () {
              isNotInFormat ? firstNameController.clear() : false;
            },
            showCrossIcon: isNotInFormat ? true : false,
          );
        });
  }

  SafeArea _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          IconButton(
            padding: const EdgeInsets.only(left: kSize24),
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.kGrey70,
            iconSize: kSize24,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Text(
              getTranslated(context, AppLocalizationsStrings.guestInformation),
              style: AppTheme.kHeading1Medium,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: kSize24,
            height: kSize24,
            margin: const EdgeInsets.only(right: kSize14),
          ),
        ],
      ),
    );
  }

  void validateAndSubmit() async {
    if (contactInformationBloc.isFormValid) {
      contactInformationBloc.onOkClicked();
      if (otaRadioButtonBloc.state.otaRadioButtonState ==
          OtaRadioButtonState.selected) {
        await contactInformationBloc.submitApiCall(
            contactInformationBloc.state.initialContactInformationArgumentData);
        if (contactInformationBloc.state.submitCustomerDetailsState ==
            SubmitCustomerDetailsState.success) {
          Navigator.pop(context);
        } else if (contactInformationBloc.state.submitCustomerDetailsState ==
            SubmitCustomerDetailsState.internetFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            OtaNoInternetAlertDialog().showAlertDialog(context);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            OtaBanner().showMaterialBanner(
                context,
                getTranslated(context,
                    AppLocalizationsStrings.updateCustomerErrorGuestInfo),
                AppColors.kBannerColor,
                _kExclamationIcon,
                bannerHeight: kSize60,
                crossAxisAlignment: CrossAxisAlignment.start);
          });
        }
      } else {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder(
      bloc: checkValidationBloc,
      builder: () {
        return Padding(
          padding:
              const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize32),
          child: SizedBox(
            height: kSize44,
            child: OtaChipButton(
                titleWidget: Center(
                  child: Text(
                    getTranslated(context, AppLocalizationsStrings.ok),
                    style:
                        AppTheme.kButton.copyWith(color: AppColors.kLight100),
                  ),
                ),
                isSelected: contactInformationBloc.isFormValid,
                onPressed: validateAndSubmit),
          ),
        );
      },
    );
  }
}
