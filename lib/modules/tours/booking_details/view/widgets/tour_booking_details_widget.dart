import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancel_default_gradient.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancel_icon.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_phone_function.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kMessageIcon = 'assets/images/icons/message.svg';
const _kPhoneNumberIcon = 'assets/images/icons/phone.svg';
const _kCancelIcon = 'assets/images/icons/minus.svg';
const _kMessageIconDisabled = 'assets/images/icons/message_disabled.svg';
const _kPhoneNumberIconDisabled = 'assets/images/icons/phone_disabled.svg';
const _kCancelIconDisabled = 'assets/images/icons/minus_disabled.svg';

class TourBookingDetailsWidget extends StatelessWidget {
  final Function()? onTap;
  final Function()? onMessageTap;
  final bool isDisabledContact;
  final bool isDisabledEmailConfirmation;
  final bool isDisableCancellation;

  const TourBookingDetailsWidget({
    this.isDisableCancellation = false,
    this.isDisabledContact = false,
    this.isDisabledEmailConfirmation = false,
    Key? key,
    this.onTap,
    this.onMessageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kSize24),
        isDisabledEmailConfirmation
            ? OtaCancelIcon(
                imageUrl: _kMessageIconDisabled,
                cancelText: getTranslated(context,
                    AppLocalizationsStrings.requestBookingConfirmation),
                style: AppTheme.kButton3.copyWith(color: AppColors.kGrey10))
            : OtaCancelDefaultGradient(
                imageUrl: _kMessageIcon,
                cancelText: getTranslated(context,
                    AppLocalizationsStrings.requestBookingConfirmation),
                style: AppTheme.kButton3.copyWith(color: AppColors.kTrueWhite),
                onTap: onMessageTap,
              ),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        const SizedBox(height: kSize24),
        isDisabledContact
            ? OtaCancelIcon(
                imageUrl: _kPhoneNumberIconDisabled,
                cancelText:
                    getTranslated(context, AppLocalizationsStrings.contact),
                style: AppTheme.kButton3.copyWith(color: AppColors.kGrey10))
            : OtaCancelDefaultGradient(
                imageUrl: _kPhoneNumberIcon,
                cancelText:
                    getTranslated(context, AppLocalizationsStrings.contact),
                style: AppTheme.kButton3.copyWith(color: AppColors.kTrueWhite),
                onTap: () => OtaPhoneFunction().makePhoneCall(
                    AppConfig().configModel.robinHoodPhoneNumber),
              ),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        const SizedBox(height: kSize24),
        OtaCancelIcon(
          imageUrl: isDisableCancellation ? _kCancelIconDisabled : _kCancelIcon,
          cancelText: getTranslated(
            context,
            AppLocalizationsStrings.cancelReservation,
          ),
          style: AppTheme.kButton3.copyWith(
              color: isDisableCancellation
                  ? AppColors.kGrey10
                  : AppColors.kCancelColor),
          onTap: isDisableCancellation ? null : onTap,
        ),
        const SizedBox(height: kSize24),
      ],
    );
  }
}
