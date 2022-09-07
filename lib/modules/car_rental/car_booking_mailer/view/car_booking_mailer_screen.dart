import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/bloc/car_booking_mailer_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/view_model/car_booking_mailer_view_model.dart';

import 'car_booking_mailer_argument_model.dart';

const Key _kKeyOk = Key('keyOk');
const Key _kKeyInputWidget = Key('kKeyInputWidget');
RegExp _kEmailRegEx = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
RegExp _allowCharacterRegEx = RegExp('[0-9a-zA-Z_@.]');
const _kCharacterLimit = 50;
const String _kCheckIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";

class CarBookingMailerScreen extends StatefulWidget {
  const CarBookingMailerScreen({Key? key}) : super(key: key);

  @override
  State<CarBookingMailerScreen> createState() => _CarBookingMailerScreenState();
}

class _CarBookingMailerScreenState extends State<CarBookingMailerScreen> {
  final OtaTextInputBloc _otaTextInputBloc = OtaTextInputBloc();
  final CarBookingMailerBloc _carBookingMailerBloc = CarBookingMailerBloc();
  final TextEditingController _textEditingController = TextEditingController();
  CarBookingMailerArgumentModel? bookingArgumentModel;
  final FocusNode _emailFocus = FocusNode();

  void _validateEmailAddress() {
    final String inputText = _textEditingController.text;
    final bool isValid = _kEmailRegEx.hasMatch(inputText);
    if (inputText.isEmpty) {
      _otaTextInputBloc.noneInputState();
    } else if (isValid) {
      _otaTextInputBloc.validInputState();
    } else {
      _otaTextInputBloc.errorInputState();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _otaTextInputBloc.dispose();
    _otaTextInputBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _otaTextInputBloc.noneInputState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingArgumentModel = ModalRoute.of(context)?.settings.arguments
          as CarBookingMailerArgumentModel;
    });
    _carBookingMailerBloc.stream.listen((event) {
      OtaDialogLoader().hideLoader(context);
      if (_carBookingMailerBloc.isLoading()) {
        OtaDialogLoader().showLoader(context);
      } else if (_carBookingMailerBloc.isFailureNetwork()) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (_carBookingMailerBloc.isSuccess() ||
          _carBookingMailerBloc.isFailure()) {
        _showPopupBanner(_carBookingMailerBloc.state.carBookingMailerStatus ==
            CarBookingMailerState.success);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bookingArgumentModel = ModalRoute.of(context)?.settings.arguments
        as CarBookingMailerArgumentModel;

    final containerHeight = MediaQuery.of(context).size.height -
        (kToolbarHeight + MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
          context,
          AppLocalizationsStrings.requestReservationConfirmation,
        ),
      ),
      body: GestureDetector(
        onTap: () => _emailFocus.unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: containerHeight),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle(context),
                _buildDescription(context),
                _buildEmailInputField(context),
                const Expanded(child: SizedBox()),
                _buildBottomBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showPopupBanner(bool isMailSend) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(
              context,
              isMailSend
                  ? AppLocalizationsStrings.mailConfirmationSuccess
                  : AppLocalizationsStrings.mailConfirmationFailure),
          isMailSend ? AppColors.kSystemSuccess : AppColors.kSystemWrong,
          isMailSend ? _kCheckIcon : _kExclamationIcon,
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize32, kSize24, kSize32, kSize0),
      child: Text(
        getTranslated(context, AppLocalizationsStrings.confirmationEmail),
        style: AppTheme.kHeading3,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize32, kSize8, kSize32, kSize17),
      child: Text(
          getTranslated(
              context, AppLocalizationsStrings.confirmationCarEmailDescription),
          style: AppTheme.kSmall1),
    );
  }

  Widget _buildEmailInputField(BuildContext context) {
    return BlocBuilder(
      bloc: _otaTextInputBloc,
      builder: () {
        return OtaTextInputWidget(
          focusNode: _emailFocus,
          key: _kKeyInputWidget,
          label: getTranslated(context, AppLocalizationsStrings.email),
          errorText: getTranslated(
              context, AppLocalizationsStrings.enterValidEmailAddress),
          autofocus: false,
          textInputFormatter: [
            FilteringTextInputFormatter.allow(_allowCharacterRegEx),
            LengthLimitingTextInputFormatter(_kCharacterLimit),
          ],
          textEditingController: _textEditingController,
          state: _otaTextInputBloc.state.otaTextInputState,
          onChanged: (_) => _validateEmailAddress(),
          onClearClick: () {
            _textEditingController.clear();
            _validateEmailAddress();
          },
          showCrossIcon: true,
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      button1: Align(
        alignment: Alignment.bottomCenter,
        child: BlocBuilder(
          bloc: _otaTextInputBloc,
          builder: () {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: _textButton(),
            );
          },
        ),
      ),
    );
  }

  Widget _textButton() {
    return OtaTextButton(
      title: getTranslated(context, AppLocalizationsStrings.ok),
      key: _kKeyOk,
      isDisabled:
          _otaTextInputBloc.state.otaTextInputState != OtaTextInputState.valid,
      onPressed: () {
        _getData(context);
      },
    );
  }

  void _getData(BuildContext context) async {
    if (bookingArgumentModel == null) return;
    _carBookingMailerBloc.sendCarBookingMailer(
      bookingArgumentModel!.bookingConfirmNo,
      _textEditingController.text,
      bookingArgumentModel!.bookingUrn,
      bookingArgumentModel!.serviceName,
    );
  }
}
