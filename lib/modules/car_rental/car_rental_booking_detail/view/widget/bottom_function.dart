import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String _kMessageIcon = 'assets/images/icons/message.svg';
const String _kPhoneNumberIcon = 'assets/images/icons/phone.svg';
const String _kCancelIcon = 'assets/images/icons/minus.svg';

const String _kCancelButtonKey = 'cancel_button_key';
const String _kMessageButtonKey = 'message_button_key';
const String _kCallButtonKey = 'call_button_key';

class BottomFunction extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;
  final Function()? onMessageTap;
  final Function()? onCancelTap;

  const BottomFunction({
    Key? key,
    required this.carBookingDetailBloc,
    required this.onMessageTap,
    required this.onCancelTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getFunctionButton(
          key: _kMessageButtonKey,
          icon: _kMessageIcon,
          titleText: AppLocalizationsStrings.requestBookingConfirmation,
          buttonState: carBookingDetailBloc.getMessageButtonState,
          context: context,
          onTap:
              carBookingDetailBloc.getMessageButtonState == ButtonState.enable
                  ? onMessageTap
                  : null,
        ),
        _getFunctionButton(
          key: _kCallButtonKey,
          icon: _kPhoneNumberIcon,
          titleText: AppLocalizationsStrings.contact,
          buttonState: carBookingDetailBloc.getCallButtonState,
          context: context,
          onTap: carBookingDetailBloc.getCallButtonState == ButtonState.enable
              ? () =>
                  _makePhoneCall(AppConfig().configModel.robinHoodPhoneNumber)
              : null,
        ),
        _getFunctionButton(
          key: _kCancelButtonKey,
          icon: _kCancelIcon,
          titleText: AppLocalizationsStrings.cancelReservation,
          buttonState: carBookingDetailBloc.getCancelledButtonState,
          context: context,
          onTap:
              carBookingDetailBloc.getCancelledButtonState == ButtonState.enable
                  ? onCancelTap
                  : null,
          textColor: AppColors.kSystemWrong,
        ),
      ],
    );
  }

  Widget _getFunctionButton({
    required String key,
    required String icon,
    required String titleText,
    required ButtonState buttonState,
    required BuildContext context,
    required Function()? onTap,
    Color? textColor,
  }) {
    if (buttonState == ButtonState.hide) {
      return const SizedBox.shrink();
    }
    return InkWell(
      onTap: onTap,
      key: Key(key),
      child: Column(
        children: [
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
          ),
          const SizedBox(height: kSize24),
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: kSize20,
                width: kSize20,
                color: buttonState == ButtonState.enable
                    ? textColor
                    : AppColors.kGrey10,
              ),
              const SizedBox(width: kSize10),
              OtaGradientText(
                gradientText: getTranslated(context, titleText),
                gradientTextStyle: AppTheme.kButton,
                textGradientStartColor: buttonState == ButtonState.enable
                    ? textColor ?? AppColors.kTextGradientStart
                    : AppColors.kGrey10,
                textGradientEndColor: buttonState == ButtonState.enable
                    ? textColor ?? AppColors.kTextGradientEnd
                    : AppColors.kGrey10,
              ),
            ],
          ),
          const SizedBox(height: kSize24),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    String number = "tel:$url";
    if (Platform.isIOS) number = "tel://$url";
    bool canCall = kDebugMode ? false : await canLaunchUrlString(number);
    if (canCall) {
      await launchUrlString(number);
    } else {
      printDebug('Could not launch $number');
    }
  }
}
