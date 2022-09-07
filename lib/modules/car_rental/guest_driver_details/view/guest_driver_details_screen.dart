import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/guest_driver_details/bloc/driver_infromation_bloc.dart';
import 'package:ota/modules/car_rental/guest_driver_details/view_model/driver_information_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/bloc/check_validation_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/format_helper.dart';

const _kDriverContactSubmit = "DriverContactSubmit";

class GuestDriverDetailsScreen extends StatefulWidget {
  const GuestDriverDetailsScreen({Key? key}) : super(key: key);

  @override
  GuestDriverDetailsScreenState createState() =>
      GuestDriverDetailsScreenState();
}

class GuestDriverDetailsScreenState extends State<GuestDriverDetailsScreen> {
  DriverInformationArgumentModel? argumentModel;
  DriverInformationBloc driverInformationBloc = DriverInformationBloc();
  late OtaRadioButtonBloc otaRadioButtonBloc = OtaRadioButtonBloc();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController flightNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  FocusNode focusNodeFirstName = FocusNode();
  FocusNode focusNodeLastName = FocusNode();
  FocusNode focusNodeMobileNumber = FocusNode();
  FocusNode focusNodeFlightNumber = FocusNode();
  CheckValidationBloc checkValidationBloc = CheckValidationBloc();

  bool showMaterialBanner = false;

  @override
  void initState() {
    super.initState();
    initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFromArgument();
      //driverInformationBloc.checkValidation();
      FocusScope.of(context).unfocus();
    });
  }

  void initialize() {
    focusNodeFirstName.addListener(() {
      if (!focusNodeFirstName.hasFocus) {
        driverInformationBloc.checkValidation(DriverValidations.firstName);
        driverInformationBloc.updateTextState();
      }
    });

    focusNodeLastName.addListener(() {
      if (!focusNodeLastName.hasFocus) {
        driverInformationBloc.checkValidation(DriverValidations.lastName);
        driverInformationBloc.updateTextState();
      }
    });
    focusNodeMobileNumber.addListener(() {
      if (!focusNodeMobileNumber.hasFocus) {
        driverInformationBloc.checkValidation(DriverValidations.mobileNumber);
        driverInformationBloc.updateTextState();
      }
    });
    focusNodeFlightNumber.addListener(() {
      if (!focusNodeFlightNumber.hasFocus) {
        driverInformationBloc.updateTextState();
      }
    });

    firstNameController.addListener(() {
      driverInformationBloc.state.initialContactInformationArgumentData
          .firstName = firstNameController.text;
      checkValidationBloc.reload();
    });
    lastNameController.addListener(() {
      driverInformationBloc.state.initialContactInformationArgumentData
          .lastName = lastNameController.text;
      checkValidationBloc.reload();
    });
    mobileNumberController.addListener(() {
      driverInformationBloc.state.initialContactInformationArgumentData
          .phoneNumber = mobileNumberController.text;
      checkValidationBloc.reload();
    });
    flightNumberController.addListener(() {
      driverInformationBloc.state.initialContactInformationArgumentData
          .flightNumber = flightNumberController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    flightNumberController.dispose();

    focusNodeFirstName.dispose();
    focusNodeLastName.dispose();
    focusNodeMobileNumber.dispose();
    focusNodeFlightNumber.dispose();

    otaRadioButtonBloc.dispose();
    driverInformationBloc.dispose();
  }

  void loadFromArgument() {
    argumentModel = ModalRoute.of(context)?.settings.arguments
        as DriverInformationArgumentModel;
    if (argumentModel != null) {
      driverInformationBloc.mapFromArgument(argumentModel!);
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
        bloc: driverInformationBloc,
        builder: () {
          return Scaffold(
            appBar: OtaAppBar(
              title: getTranslated(
                  context, AppLocalizationsStrings.driverInformation),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(
                        bottom:
                            kSize100 + MediaQuery.of(context).padding.bottom),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kSize32, vertical: kSize16),
                      children: [
                        Text(
                          getTranslated(
                              context, AppLocalizationsStrings.informationText),
                          style: AppTheme.kSmallRegular
                              .copyWith(color: AppColors.kSecondary),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: kSize26),
                        _buildFirstNameTextWidget(context),
                        const SizedBox(height: kSize30),
                        _buildLastNameTextWidget(context),
                        const SizedBox(height: kSize30),
                        _buildPhoneNumberTextWidget(context),
                        const SizedBox(height: kSize30),
                        _buildAgeWidget(context),
                        const SizedBox(height: kSize30),
                        _buildFlightNumberWidget(context),
                      ],
                    ),
                  ),
                  _buildBottomBar(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BlocBuilder _buildPhoneNumberTextWidget(BuildContext context) {
    return BlocBuilder(
        bloc: driverInformationBloc.state.mobileNumberBloc!,
        builder: () {
          bool isNotInFormat = kInvalidNameFormatter.hasMatch(
                  driverInformationBloc
                      .state.initialContactInformationArgumentData.phoneNumber!)
              ? true
              : false;
          return OtaTextInputWidget(
            textInputType: TextInputType.number,
            focusNode: focusNodeMobileNumber,
            errorLabel: getTranslated(
                context, AppLocalizationsStrings.phoneNumberLabel),
            errorText: getTranslated(
                context, AppLocalizationsStrings.mobileNumberErrorText),
            state: driverInformationBloc
                .state.mobileNumberBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getPhoneNumberFormatter(),
            textEditingController: driverInformationBloc.state
                        .initialContactInformationArgumentData.phoneNumber !=
                    null
                ? (mobileNumberController
                  ..text = driverInformationBloc.state
                          .initialContactInformationArgumentData.phoneNumber ??
                      "")
                : mobileNumberController,
            label: getTranslated(
                context, AppLocalizationsStrings.phoneNumberLabel),
            placeHolder: getTranslated(
                context, AppLocalizationsStrings.phoneNumberPlaceholder),
            padding: EdgeInsets.zero,
            onClearClick: () {
              isNotInFormat ? mobileNumberController.clear() : false;
            },
            showCrossIcon: isNotInFormat ? true : false,
          );
        });
  }

  Widget _buildAgeWidget(BuildContext context) {
    return BlocBuilder(
        bloc: driverInformationBloc,
        builder: () {
          return GestureDetector(
            key: const Key('driver_age_selection'),
            child: OtaTextInputWidget(
              textInputFormatter: FormatHelper.getInputFormatter(),
              isEnabled: false,
              textEditingController: driverInformationBloc
                          .state.initialContactInformationArgumentData.age !=
                      0
                  ? (ageController
                    ..text = (driverInformationBloc.state
                                .initialContactInformationArgumentData.age ??
                            0)
                        .toString())
                  : ageController,
              label: getTranslated(
                  context, AppLocalizationsStrings.driverAgeLabel),
              placeHolder: getTranslated(
                  context, AppLocalizationsStrings.driverAgePlaceholder),
              padding: EdgeInsets.zero,
            ),
            onTap: () {
              _showDriverAgeSheet(context, driverInformationBloc);
            },
          );
        });
  }

  void _showDriverAgeSheet(BuildContext context, DriverInformationBloc bloc) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColors.kLight100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kSize24),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: OtaCupertinoWidget(
            title: getTranslated(
                context, AppLocalizationsStrings.driverAgePlaceholder),
            maxInputValueLimit: getMaxInputAgeLimit(
                bloc.state.initialContactInformationArgumentData.maxAge),
            minInputValueLimit: getMinInputValueLimit(
                bloc.state.initialContactInformationArgumentData.minAge),
            oldAge: getOldAge(
                bloc.state.initialContactInformationArgumentData.age!,
                bloc.state.initialContactInformationArgumentData.minAge),
            onAgreeClicked: (newAge) {
              FocusScope.of(context).unfocus();
              driverInformationBloc.updateDriverAge(
                age: getMinInputValueLimit(bloc
                        .state.initialContactInformationArgumentData.minAge) +
                    (newAge - 1),
              );
            },
          ),
        );
      },
    );
  }

  int getMaxInputAgeLimit(String? maxAge) {
    if (maxAge != null) {
      return int.parse(maxAge);
    } else {
      return AppConfig().configModel.carDriverMaxAge;
    }
  }

  int getMinInputValueLimit(String? minAge) {
    if (minAge != null) {
      return int.parse(minAge);
    }
    return AppConfig().configModel.carDriverMinAge;
  }

  int getOldAge(int age, String? minAge) {
    if (minAge != null) {
      return (age - int.parse(minAge)) + 1;
    }
    return (age - AppConfig().configModel.carDriverMinAge) + 1;
  }

  BlocBuilder _buildFlightNumberWidget(BuildContext context) {
    return BlocBuilder(
        bloc: driverInformationBloc.state.flightNumberBloc!,
        builder: () {
          bool isNotInFormat = kInvalidNameFormatter.hasMatch(
                  driverInformationBloc.state
                      .initialContactInformationArgumentData.flightNumber!)
              ? true
              : false;
          return OtaTextInputWidget(
            focusNode: focusNodeFlightNumber,
            errorLabel:
                getTranslated(context, AppLocalizationsStrings.lastName),
            errorText: getTranslated(
                context, AppLocalizationsStrings.lastNameErrorText),
            state: driverInformationBloc
                .state.flightNumberBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getNameFormatter(),
            textEditingController: driverInformationBloc.state
                        .initialContactInformationArgumentData.flightNumber !=
                    null
                ? (flightNumberController
                  ..text = driverInformationBloc.state
                          .initialContactInformationArgumentData.flightNumber ??
                      "")
                : flightNumberController,
            label: getTranslated(
                context, AppLocalizationsStrings.flightNumberLabel),
            placeHolder: getTranslated(
                context, AppLocalizationsStrings.flightNumberPlaceholder),
            padding: EdgeInsets.zero,
            onClearClick: () {
              isNotInFormat ? flightNumberController.clear() : false;
            },
            showCrossIcon: isNotInFormat ? true : false,
          );
        });
  }

  BlocBuilder _buildLastNameTextWidget(BuildContext context) {
    return BlocBuilder(
        bloc: driverInformationBloc.state.lastNameBloc!,
        builder: () {
          bool isNotInFormat = kInvalidNameFormatter.hasMatch(
                  driverInformationBloc
                      .state.initialContactInformationArgumentData.lastName!)
              ? true
              : false;
          return OtaTextInputWidget(
            focusNode: focusNodeLastName,
            errorLabel:
                getTranslated(context, AppLocalizationsStrings.lastName),
            errorText: getTranslated(
                context, AppLocalizationsStrings.lastNameErrorText),
            state: driverInformationBloc
                .state.lastNameBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getNameFormatter(),
            textEditingController: driverInformationBloc
                        .state.initialContactInformationArgumentData.lastName !=
                    null
                ? (lastNameController
                  ..text = driverInformationBloc.state
                          .initialContactInformationArgumentData.lastName ??
                      "")
                : lastNameController,
            label: getTranslated(context, AppLocalizationsStrings.lastName),
            placeHolder: getTranslated(
                context, AppLocalizationsStrings.enterLastNamePlaceHolder),
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
        bloc: driverInformationBloc.state.firstNameBloc!,
        builder: () {
          bool isNotInFormat = kInvalidNameFormatter.hasMatch(
                  driverInformationBloc
                      .state.initialContactInformationArgumentData.firstName)
              ? true
              : false;
          return OtaTextInputWidget(
            focusNode: focusNodeFirstName,
            errorLabel: getTranslated(context, AppLocalizationsStrings.name),
            errorText: getTranslated(
                context, AppLocalizationsStrings.firstNameErrorText),
            state: driverInformationBloc
                .state.firstNameBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getNameFormatter(),
            textEditingController: driverInformationBloc.state
                    .initialContactInformationArgumentData.firstName.isNotEmpty
                ? (firstNameController
                  ..text = driverInformationBloc
                      .state.initialContactInformationArgumentData.firstName)
                : firstNameController,
            label: getTranslated(context, AppLocalizationsStrings.name),
            placeHolder: getTranslated(
                context, AppLocalizationsStrings.enterNamePlaceHolder),
            padding: EdgeInsets.zero,
            onClearClick: () {
              isNotInFormat ? firstNameController.clear() : false;
            },
            showCrossIcon: isNotInFormat ? true : false,
          );
        });
  }

  Widget _buildBottomBar(BuildContext context) {
    return BlocBuilder(
      bloc: checkValidationBloc,
      builder: () {
        return Padding(
          padding:
              const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize32),
          child: SizedBox(
            height: kSize44,
            child: OtaChipButton(
              key: const Key(_kDriverContactSubmit),
              titleWidget: Center(
                child: Text(
                  getTranslated(context, AppLocalizationsStrings.agree),
                  style: AppTheme.kButton.copyWith(color: AppColors.kLight100),
                ),
              ),
              isSelected: driverInformationBloc.isFormValid,
              onPressed: () {
                if (driverInformationBloc.isFormValid) {
                  driverInformationBloc.onOkClicked();
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
