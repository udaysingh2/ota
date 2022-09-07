import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/format_helper.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_guest_information_bloc.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/view/widget/country_picker.dart';
import 'package:ota/modules/tours/reservation/view/widget/date_picker_widget.dart';

const _kGuestImage = "assets/images/icons/guest_info.svg";

class TicketGuestInformation extends StatefulWidget {
  const TicketGuestInformation({Key? key}) : super(key: key);

  @override
  TicketGuestInformationState createState() => TicketGuestInformationState();
}

class TicketGuestInformationState extends State<TicketGuestInformation> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passportCountryController =
      TextEditingController();
  final TextEditingController _passportIdController = TextEditingController();
  final TextEditingController _passportIssuingCountryController =
      TextEditingController();
  final TextEditingController _passportExpirationDateController =
      TextEditingController();

  TicketGuestInformationArgumentModel get _guestInfoArgumentModel =>
      ModalRoute.of(context)?.settings.arguments
          as TicketGuestInformationArgumentModel;
  final TicketGuestInformationBloc _guestInformationBloc =
      TicketGuestInformationBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _guestInformationBloc.setGuestArgumentData(_guestInfoArgumentModel);
      _setUserData();
    });
  }

  void _setUserData() {
    if (_guestInfoArgumentModel.updateGuestInfo != null) {
      TicketGuestInformationData updateGuestInfo =
          _guestInfoArgumentModel.updateGuestInfo!;
      _firstNameController.text = updateGuestInfo.guestFirstName;
      _lastNameController.text = updateGuestInfo.guestLastName;
      _weightController.text = updateGuestInfo.guestWeight ?? '';
      if (updateGuestInfo.selectedDob != null) {
        _dobController.text =
            Helpers.getYYYYmmddFromDateTime(updateGuestInfo.selectedDob);
      }
      _passportCountryController.text =
          updateGuestInfo.selectedPassportCountry ?? '';
      _passportIdController.text = updateGuestInfo.guestPassportId ?? '';
      _passportIssuingCountryController.text =
          updateGuestInfo.selectedPassportIssuingCountry ?? '';
      if (updateGuestInfo.selectedPassportValidityDate != null) {
        _passportExpirationDateController.text =
            Helpers.getYYYYmmddFromDateTime(
                updateGuestInfo.selectedPassportValidityDate);
      }
      _guestInformationBloc.setGuestUserData(updateGuestInfo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _weightController.dispose();
    _dobController.dispose();
    _passportCountryController.dispose();
    _passportIdController.dispose();
    _passportIssuingCountryController.dispose();
    _passportExpirationDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
            context, AppLocalizationsStrings.ticketHoldersInformation),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder(
          bloc: _guestInformationBloc,
          builder: () {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSize32),
              child: Column(
                children: [
                  _getHeaderText(),
                  const SizedBox(height: kSize17),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: kSize5),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height -
                                  kSize150),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                if (_guestInfoArgumentModel
                                        .isGuestNameRequired ??
                                    false)
                                  _buildFirstNameTextWidget(),
                                if (_guestInfoArgumentModel
                                        .isGuestNameRequired ??
                                    false)
                                  _buildLastNameTextWidget(),
                                if (_guestInfoArgumentModel.isWeightRequired ??
                                    false)
                                  _buildWeightTextWidget(),
                                if (_guestInfoArgumentModel
                                        .isDateOfBirthRequired ??
                                    false)
                                  _buildDateOfBirthTextWidget(),
                                if (_guestInfoArgumentModel
                                        .isPassportCountryRequired ??
                                    false)
                                  _buildCountryPassportTextWidget(),
                                if (_guestInfoArgumentModel
                                        .isPassportIdRequired ??
                                    false)
                                  _buildPassportIdTextWidget(),
                                if (_guestInfoArgumentModel
                                        .isPassportCountryIssueRequired ??
                                    false)
                                  _buildPassportIssungCountryTextWidget(),
                                if (_guestInfoArgumentModel
                                        .isPassportValidDateRequired ??
                                    false)
                                  _buildPassportExpirationDateTextWidget(),
                                const Spacer(),
                                _buildSubmitButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getHeaderText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.ticketHolder)
                  .addTrailingSpace() +
              _guestInfoArgumentModel.guestIndex.toString(),
          style: AppTheme.kHBody.copyWith(color: AppColors.kGreyScale),
        ),
        SvgPicture.asset(_kGuestImage)
      ],
    );
  }

  BlocBuilder _buildFirstNameTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.firstNameBloc!,
      builder: () {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSize30, top: kSize10),
          child: OtaTextInputWidget(
            errorLabel: getTranslated(
                context, AppLocalizationsStrings.reservePersonName),
            errorText: getTranslated(
                context, AppLocalizationsStrings.firstNameErrorText),
            state: _guestInformationBloc
                .state.firstNameBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getInputFormatter(),
            textEditingController: _firstNameController,
            label: getTranslated(
                context, AppLocalizationsStrings.reservePersonName),
            placeHolder:
                getTranslated(context, AppLocalizationsStrings.enterName),
            padding: EdgeInsets.zero,
            onChanged: (text) {
              _guestInformationBloc.state.guestInformationArgumentData
                  .guestFirstName = text.trim();
            },
          ),
        );
      },
    );
  }

  BlocBuilder _buildLastNameTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.lastNameBloc!,
      builder: () {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSize30),
          child: OtaTextInputWidget(
            errorLabel: getTranslated(
                context, AppLocalizationsStrings.reservePersonLastName),
            errorText: getTranslated(
                context, AppLocalizationsStrings.lastNameErrorText),
            state: _guestInformationBloc
                .state.lastNameBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getInputFormatter(),
            textEditingController: _lastNameController,
            label: getTranslated(
                context, AppLocalizationsStrings.reservePersonLastName),
            placeHolder:
                getTranslated(context, AppLocalizationsStrings.enterLastName),
            padding: EdgeInsets.zero,
            onChanged: (text) {
              _guestInformationBloc.state.guestInformationArgumentData
                  .guestLastName = text.trim();
            },
          ),
        );
      },
    );
  }

  BlocBuilder _buildWeightTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.guestWeightBloc!,
      builder: () {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSize30),
          child: OtaTextInputWidget(
            errorLabel: getTranslated(context, AppLocalizationsStrings.weight),
            errorText:
                getTranslated(context, AppLocalizationsStrings.weightErrorText),
            state: _guestInformationBloc
                .state.guestWeightBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getWeightFormatter(),
            textEditingController: _weightController,
            label: getTranslated(context, AppLocalizationsStrings.weight),
            placeHolder:
                getTranslated(context, AppLocalizationsStrings.enterWeight),
            padding: EdgeInsets.zero,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            onChanged: (text) {
              _guestInformationBloc
                  .state.guestInformationArgumentData.guestWeight = text.trim();
            },
          ),
        );
      },
    );
  }

  BlocBuilder _buildDateOfBirthTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.guestDobBloc!,
      builder: () {
        return GestureDetector(
          onTap: () {
            DateTime currentDate =
                DateTime.now().subtract(const Duration(days: 1));
            _buildDatePicker(
              maximumDate: currentDate,
              minimumDate:
                  currentDate.subtract(const Duration(days: 365 * 100)),
              initialDateTime: currentDate,
              isForDOB: true,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: kSize30),
            child: OtaTextInputWidget(
              errorLabel:
                  getTranslated(context, AppLocalizationsStrings.dateOfBirth),
              errorText:
                  getTranslated(context, AppLocalizationsStrings.dobErrorText),
              state: _guestInformationBloc
                  .state.guestDobBloc!.state.otaTextInputState,
              textEditingController: _dobController,
              label:
                  getTranslated(context, AppLocalizationsStrings.dateOfBirth),
              placeHolder: getTranslated(
                  context, AppLocalizationsStrings.selectDateOfBirth),
              padding: EdgeInsets.zero,
              isEnabled: false,
            ),
          ),
        );
      },
    );
  }

  BlocBuilder _buildCountryPassportTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.guestPassportCountryBloc!,
      builder: () {
        return GestureDetector(
          onTap: () => _buildCountryPicker(
            title:
                getTranslated(context, AppLocalizationsStrings.selectCountry),
            isForPassportCountry: true,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: kSize30),
            child: OtaTextInputWidget(
              errorLabel: getTranslated(
                  context, AppLocalizationsStrings.countryAsInPassport),
              errorText: getTranslated(context,
                  AppLocalizationsStrings.countryAsInPassportIsRequired),
              state: _guestInformationBloc
                  .state.guestPassportCountryBloc!.state.otaTextInputState,
              textEditingController: _passportCountryController,
              label: getTranslated(
                  context, AppLocalizationsStrings.countryAsInPassport),
              placeHolder:
                  getTranslated(context, AppLocalizationsStrings.selectCountry),
              padding: EdgeInsets.zero,
              isEnabled: false,
              suffixIcon: const Icon(
                Icons.expand_more,
                color: AppColors.kGrey70,
              ),
            ),
          ),
        );
      },
    );
  }

  BlocBuilder _buildPassportIdTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.guestPassportIdBloc!,
      builder: () {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSize30),
          child: OtaTextInputWidget(
            errorLabel:
                getTranslated(context, AppLocalizationsStrings.passportNo),
            errorText: getTranslated(
                context, AppLocalizationsStrings.passportNoIsRequired),
            state: _guestInformationBloc
                .state.guestPassportIdBloc!.state.otaTextInputState,
            textInputFormatter: FormatHelper.getPassportIdFormatter(),
            textEditingController: _passportIdController,
            label: getTranslated(context, AppLocalizationsStrings.passportNo),
            placeHolder:
                getTranslated(context, AppLocalizationsStrings.enterPassportNo),
            padding: EdgeInsets.zero,
            textCapitalization: TextCapitalization.characters,
            onChanged: (text) {
              _guestInformationBloc.state.guestInformationArgumentData
                  .guestPassportId = text.trim();
            },
          ),
        );
      },
    );
  }

  BlocBuilder _buildPassportIssungCountryTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.guestPassportIssuingCountryBloc!,
      builder: () {
        return GestureDetector(
          onTap: () => _buildCountryPicker(
            title:
                getTranslated(context, AppLocalizationsStrings.selectCountry),
            isForPassportCountry: false,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: kSize30),
            child: OtaTextInputWidget(
              errorLabel: getTranslated(
                  context, AppLocalizationsStrings.passportIssuingCountry),
              errorText: getTranslated(context,
                  AppLocalizationsStrings.passportIssuingCountryIsRequired),
              state: _guestInformationBloc.state
                  .guestPassportIssuingCountryBloc!.state.otaTextInputState,
              textEditingController: _passportIssuingCountryController,
              label: getTranslated(
                  context, AppLocalizationsStrings.passportIssuingCountry),
              placeHolder:
                  getTranslated(context, AppLocalizationsStrings.selectCountry),
              padding: EdgeInsets.zero,
              isEnabled: false,
              suffixIcon: const Icon(
                Icons.expand_more,
                color: AppColors.kGrey70,
              ),
            ),
          ),
        );
      },
    );
  }

  BlocBuilder _buildPassportExpirationDateTextWidget() {
    return BlocBuilder(
      bloc: _guestInformationBloc.state.guestPassportExpirationDateBloc!,
      builder: () {
        return GestureDetector(
          onTap: () {
            DateTime currentDate = DateTime.now().add(const Duration(days: 1));
            _buildDatePicker(
              minimumDate: currentDate,
              maximumDate: currentDate.add(const Duration(days: 3650)),
              initialDateTime: currentDate,
              isForDOB: false,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: kSize30),
            child: OtaTextInputWidget(
              errorLabel: getTranslated(
                  context, AppLocalizationsStrings.passportExpiryDate),
              errorText: getTranslated(context,
                  AppLocalizationsStrings.passportExpiryDateIsRequired),
              state: _guestInformationBloc.state
                  .guestPassportExpirationDateBloc!.state.otaTextInputState,
              textEditingController: _passportExpirationDateController,
              label: getTranslated(
                  context, AppLocalizationsStrings.passportExpiryDate),
              placeHolder: getTranslated(
                  context, AppLocalizationsStrings.selectPassportExpiryDate),
              padding: EdgeInsets.zero,
              isEnabled: false,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      height: kSize40,
      width: kSize140,
      margin: const EdgeInsets.only(bottom: kSize34),
      child: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.ok),
        isDisabled: !_guestInformationBloc.isAllFieldValid(),
        onPressed: () {
          Navigator.of(context)
              .pop(_guestInformationBloc.state.guestInformationArgumentData);
        },
      ),
    );
  }

  _buildDatePicker({
    required DateTime minimumDate,
    required DateTime maximumDate,
    required DateTime initialDateTime,
    required bool isForDOB,
  }) async {
    FocusScope.of(context).unfocus();
    var data = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return DatePickerWidget(
          maximumDate: maximumDate,
          minimumDate: minimumDate,
          initialDateTime: initialDateTime,
        );
      },
    );
    if (data != null) {
      DateTime dateTime = data;
      if (isForDOB) {
        _dobController.text = Helpers.getYYYYmmddFromDateTime(dateTime);
      } else {
        _passportExpirationDateController.text =
            Helpers.getYYYYmmddFromDateTime(dateTime);
      }
      _guestInformationBloc.updateSelectedDateValue(
          selectedDate: dateTime, isForDOB: isForDOB);
    }
  }

  _buildCountryPicker({
    required String title,
    required bool isForPassportCountry,
  }) async {
    FocusScope.of(context).unfocus();
    var data = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return CountryPicker(
          screenTitle: title,
          countriesName: AppConfig().getCountryList(),
        );
      },
    );
    if (data != null) {
      String countryViewModel = data;
      if (isForPassportCountry) {
        _passportCountryController.text = countryViewModel;
      } else {
        _passportIssuingCountryController.text = countryViewModel;
      }
      _guestInformationBloc.updateSelectedCountryValue(
          selectedCountry: countryViewModel,
          isForPassportCountry: isForPassportCountry);
    }
  }
}
