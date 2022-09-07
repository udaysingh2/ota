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
import 'package:ota/modules/ota_common/bloc/ota_booking_mailer_bloc.dart';
import 'package:ota/modules/ota_common/model/ota_booking_mailer_argument_model.dart';
import 'package:ota/modules/ota_common/model/ota_booking_mailer_view_model.dart';

const Key _kKeyOk = Key('keyOk');
const Key _kKeyInputWidget = Key('kKeyInputWidget');
RegExp _kEmailRegEx = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
RegExp _allowCharacterRegEx = RegExp('[0-9a-zA-Z_@.]');
const _kCharacterLimit = 50;
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kCheckIcon = "assets/images/icons/uil_check-circle.svg";

class OtaBookingMailerScreen extends StatefulWidget {
  const OtaBookingMailerScreen({Key? key}) : super(key: key);

  @override
  State<OtaBookingMailerScreen> createState() => _OtaBookingMailerScreenState();
}

class _OtaBookingMailerScreenState extends State<OtaBookingMailerScreen> {
  final OtaTextInputBloc _otaTextInputBloc = OtaTextInputBloc();
  final OtaBookingMailerBloc _otaBookingMailerBloc = OtaBookingMailerBloc();
  final TextEditingController _textEditingController = TextEditingController();
  OtaBookingMailerArgumentModel? bookingArgumentModel;

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

  void _popScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
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
          as OtaBookingMailerArgumentModel;
    });
    _otaBookingMailerBloc.stream.listen(
      (event) {
        if (_otaBookingMailerBloc.state.otaBookingMailerStatus ==
            OtaBookingMailerState.loading) {
          OtaDialogLoader().showLoader(context);
        } else {
          OtaDialogLoader().hideLoader(context);
        }
        if (_otaBookingMailerBloc.state.otaBookingMailerStatus ==
            OtaBookingMailerState.success) {
          OtaBanner().showMaterialBanner(
            context,
            getTranslated(
                context, AppLocalizationsStrings.confirmEmailSuccessMessage),
            AppColors.kBannerCSuccessColor,
            _kCheckIcon,
          );
          _popScreen();
        } else if (_otaBookingMailerBloc.state.otaBookingMailerStatus ==
            OtaBookingMailerState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        } else if (_otaBookingMailerBloc.state.otaBookingMailerStatus ==
            OtaBookingMailerState.failure) {
          OtaBanner().showMaterialBanner(
            context,
            getTranslated(
                context, AppLocalizationsStrings.confirmEmailFailureMessage),
            AppColors.kBannerColor,
            _kExclamationIcon,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.fromLTRB(kSize24, kSize24, kSize24, kSize0),
      child: Text(
        getTranslated(context, AppLocalizationsStrings.confirmationEmail),
        style: AppTheme.kHeading1Medium,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize8, kSize24, kSize17),
      child: Text(
        getTranslated(
            context, AppLocalizationsStrings.providerWillSendConfirmationEmail),
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
      ),
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
              child: OtaTextButton(
                title: getTranslated(context, AppLocalizationsStrings.ok),
                key: _kKeyOk,
                isDisabled: _otaTextInputBloc.state.otaTextInputState !=
                    OtaTextInputState.valid,
                onPressed: () {
                  if (bookingArgumentModel != null) {
                    _otaBookingMailerBloc.sendBookingMailer(
                        bookingArgumentModel!.bookingConfirmNo,
                        _textEditingController.text,
                        bookingArgumentModel!.bookingUrn,
                        bookingArgumentModel!.bookingType);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
