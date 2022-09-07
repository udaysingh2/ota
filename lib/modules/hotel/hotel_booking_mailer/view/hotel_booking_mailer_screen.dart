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
import 'package:ota/modules/hotel/hotel_booking_mailer/bloc/hotel_booking_mailer_bloc.dart';
import 'package:ota/modules/hotel/hotel_booking_mailer/view_model/hotel_booking_mailer_view_model.dart';

import 'hotel_booking_mailer_argument_model.dart';

const Key _kKeyOk = Key('keyOk');
const Key _kKeyInputWidget = Key('kKeyInputWidget');
RegExp _kEmailRegEx = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
RegExp _allowCharacterRegEx = RegExp('[0-9a-zA-Z_@.]');
const _kCharacterLimit = 50;
const String _kCheckCircle = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";

class HotelBookingMailerScreen extends StatefulWidget {
  const HotelBookingMailerScreen({Key? key}) : super(key: key);

  @override
  State<HotelBookingMailerScreen> createState() =>
      _HotelBookingMailerScreenState();
}

class _HotelBookingMailerScreenState extends State<HotelBookingMailerScreen> {
  final OtaTextInputBloc _otaTextInputBloc = OtaTextInputBloc();
  final HotelBookingMailerBloc _hotelBookingMailerBloc =
      HotelBookingMailerBloc();
  final TextEditingController _textEditingController = TextEditingController();
  HotelBookingMailerArgumentModel? bookingArgumentModel;

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

  void _showEmailStatusBanner(
      String emailStatusMessage, Color backgroundColor, String iconString) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OtaBanner().showMaterialBanner(
        context,
        getTranslated(context, emailStatusMessage),
        backgroundColor,
        iconString,
        crossAxisAlignment: CrossAxisAlignment.start,
        bannerHeight: kSize72,
      );
    });
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
          as HotelBookingMailerArgumentModel;
      _hotelBookingMailerBloc.stream.listen((event) {
        if (_hotelBookingMailerBloc.isLoading()) {
          OtaDialogLoader().showLoader(context);
        } else {
          OtaDialogLoader().hideLoader(context);
        }
        if (_hotelBookingMailerBloc.isSuccess()) {
          _showEmailStatusBanner(
              AppLocalizationsStrings.confirmEmailSuccessMessage,
              AppColors.kSystemSuccess,
              _kCheckCircle);
        } else if (_hotelBookingMailerBloc.isFailure()) {
          _showEmailStatusBanner(
              AppLocalizationsStrings.confirmEmailFailureMessage,
              AppColors.kBannerColor,
              _kExclamationIcon);
        } else if (_hotelBookingMailerBloc.state.hotelBookingMailerStatus ==
            HotelBookingMailerState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bookingArgumentModel = ModalRoute.of(context)?.settings.arguments
        as HotelBookingMailerArgumentModel;
    bookingArgumentModel?.car == true
        ? _hotelBookingMailerBloc.stream.listen((event) {
            _hotelBookingMailerBloc.isLoading()
                ? OtaDialogLoader().showLoader(context)
                : OtaDialogLoader().hideLoader(context);
          })
        : null;
    final containerHeight = MediaQuery.of(context).size.height -
        (kToolbarHeight + MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
          context,
          AppLocalizationsStrings.requestReservationConfirmation,
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
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
        ],
      ),
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
      child: bookingArgumentModel?.car == true
          ? Text(
              getTranslated(context,
                  AppLocalizationsStrings.confirmationCarEmailDescription),
              style: AppTheme.kSmall1)
          : Text(
              getTranslated(context,
                  AppLocalizationsStrings.confirmationEmailDescription),
              style: AppTheme.kSmall1),
    );
  }

  Widget _buildEmailInputField(BuildContext context) {
    return BlocBuilder(
      bloc: _otaTextInputBloc,
      builder: () {
        return OtaTextInputWidget(
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
            return bookingArgumentModel?.car == true
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: _textButton(0),
                  )
                : _textButton(kSize40);
          },
        ),
      ),
    );
  }

  Widget _textButton(double padding) {
    return OtaTextButton(
      title: getTranslated(context, AppLocalizationsStrings.ok),
      key: _kKeyOk,
      isDisabled:
          _otaTextInputBloc.state.otaTextInputState != OtaTextInputState.valid,
      textHorizontalPadding: padding,
      onPressed: () {
        _getData(context);
      },
    );
  }

  void _getData(BuildContext context) async {
    if (bookingArgumentModel == null) return;
    _hotelBookingMailerBloc.sendHotelBookingMailer(
      bookingArgumentModel!.bookingConfirmNo,
      _textEditingController.text,
      bookingArgumentModel!.bookingUrn,
      bookingArgumentModel!.serviceName,
    );
  }
}
