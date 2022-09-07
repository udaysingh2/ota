import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancel_icon.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _kMessageIcon = 'assets/images/icons/message.svg';
const _kPhoneNumberIcon = 'assets/images/icons/phone.svg';
const _kCancelIcon = 'assets/images/icons/minus.svg';
const _kMessageIconDisabled = 'assets/images/icons/message_disabled.svg';
const _kPhoneNumberIconDisabled = 'assets/images/icons/phone_disabled.svg';
const _kCancelIconDisabled = 'assets/images/icons/minus_disabled.svg';
const _kDividerColor = Color(0xFFE3E4E8);

class BookingDetailsWidget extends StatelessWidget {
  final Function()? onTap;
  final Function()? onMessageTap;
  final List<OtaCancellationPolicyListModel>? cancellationPolicyList;
  final bool isDisabled;
  final bool isDisableCancellation;
  final ActivityStatus? activityStatus;

  const BookingDetailsWidget({
    this.isDisabled = false,
    this.isDisableCancellation = false,
    Key? key,
    this.cancellationPolicyList,
    this.activityStatus,
    this.onTap,
    this.onMessageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        children: [
          isDisabled
              ? OtaCancelIcon(
                  imageUrl: _kMessageIconDisabled,
                  cancelText: getTranslated(context,
                      AppLocalizationsStrings.requestBookingConfirmation),
                  style: AppTheme.kButton.copyWith(color: AppColors.kGrey10),
                )
              : _isReservationIdHide(activityStatus)
                  ? OtaCancelIcon(
                      imageUrl: _kMessageIcon,
                      cancelText: getTranslated(context,
                          AppLocalizationsStrings.requestBookingConfirmation),
                      style: AppTheme.kButton
                          .copyWith(color: AppColors.kTrueWhite),
                      onTap: onMessageTap,
                      textWidget: _getEnabledGradientTextWidget(context,
                          AppLocalizationsStrings.requestBookingConfirmation),
                    )
                  : OtaCancelIcon(
                      imageUrl: _kMessageIconDisabled,
                      cancelText: getTranslated(context,
                          AppLocalizationsStrings.requestBookingConfirmation),
                      style:
                          AppTheme.kButton.copyWith(color: AppColors.kGrey10),
                    ),
          const OtaHorizontalDivider(
            dividerColor: _kDividerColor,
            height: kSize32,
          ),
          isDisabled
              ? OtaCancelIcon(
                  imageUrl: _kPhoneNumberIconDisabled,
                  cancelText:
                      getTranslated(context, AppLocalizationsStrings.contact),
                  style: AppTheme.kButton.copyWith(color: AppColors.kGrey10),
                )
              : OtaCancelIcon(
                  imageUrl: _kPhoneNumberIcon,
                  cancelText:
                      getTranslated(context, AppLocalizationsStrings.contact),
                  style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
                  onTap: () {
                    _makePhoneCall(
                        AppConfig().configModel.robinHoodPhoneNumber);
                  },
                  textWidget: _getEnabledGradientTextWidget(
                      context, AppLocalizationsStrings.contact),
                ),
          const OtaHorizontalDivider(
            dividerColor: _kDividerColor,
            height: kSize32,
          ),
          Offstage(
            offstage: activityStatus == ActivityStatus.completed,
            child: OtaCancelIcon(
              imageUrl:
                  isDisableCancellation ? _kCancelIconDisabled : _kCancelIcon,
              cancelText: getTranslated(
                context,
                AppLocalizationsStrings.cancelReservation,
              ),
              style: AppTheme.kButton.copyWith(
                  color: isDisableCancellation
                      ? AppColors.kGrey10
                      : AppColors.kCancelColor),
              onTap: isDisableCancellation ? null : onTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEnabledGradientTextWidget(BuildContext context, String titleKey) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return AppColors.gradient1.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        getTranslated(context, titleKey),
        style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    String number = "tel:$url";
    if (Platform.isIOS) number = "tel://$url";

    if (await canLaunchUrlString(number)) {
      await launchUrlString(number);
    } else {
      throw 'Could not launch $number';
    }
  }

  bool _isReservationIdHide(ActivityStatus? activityStatus) =>
      !(activityStatus == ActivityStatus.paymentPending ||
          activityStatus == ActivityStatus.awaitingConfirmation ||
          activityStatus == ActivityStatus.awaitingCancellation);
}
