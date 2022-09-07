import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_gradient_text_with_svg.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';

class HotelBookingDetailsBookingStatus extends StatelessWidget {
  final String referenceId;
  final String bookingId;
  final String activityStatus;
  final ActivityStatus state;

  const HotelBookingDetailsBookingStatus({
    Key? key,
    required this.referenceId,
    required this.bookingId,
    required this.activityStatus,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          offstage: activityStatus.isEmpty,
          child: _getBookingStatus(
            state,
            activityStatus,
          ),
        ),
        const SizedBox(
          height: kSize8,
        ),
        if (_isReservationIdHide())
          _getText(
              getTranslated(context, AppLocalizationsStrings.reservationId),
              bookingId,
              AppTheme.kBodyMedium),
        const SizedBox(height: kSize4),
        _getText(
            getTranslated(context, AppLocalizationsStrings.referenceId),
            referenceId,
            AppTheme.kSmallMedium.copyWith(color: AppColors.kGrey50)),
      ],
    );
  }

  bool _isReservationIdHide() => !(state == ActivityStatus.paymentFailed ||
      state == ActivityStatus.hotelRejected ||
      state == ActivityStatus.paymentPending ||
      state == ActivityStatus.awaitingConfirmation);

  Widget _getText(String id, String idNumber, TextStyle textStyle) {
    return RichText(
        text: TextSpan(
            style: textStyle.copyWith(fontFamily: kFontFamily),
            children: [
          TextSpan(text: id.addTrailingColon()),
          TextSpan(text: idNumber)
        ]));
  }

  Widget _getBookingStatus(ActivityStatus state, String activityStatus) {
    return state == ActivityStatus.userCancelled ||
            state == ActivityStatus.paymentFailed ||
            state == ActivityStatus.hotelRejected ||
            state == ActivityStatus.paymentPending ||
            state == ActivityStatus.awaitingCancellation ||
            state == ActivityStatus.awaitingConfirmation
        ? Text(activityStatus,
            style: AppTheme.kHBody.copyWith(color: AppColors.kSystemWrong))
        : HotelBookingDetailsWithGradient(
            gradientText: activityStatus,
            isGradientText: false,
          );
  }
}
