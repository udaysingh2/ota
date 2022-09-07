import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/booking_details/helper/tour_booking_detail_helper.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_gradient_text_with_svg.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

class TourBookingDetailsBookingStatus extends StatelessWidget {
  final String bookingStatus;
  final String? referenceId;
  final String? bookingId;
  final String? orderId;
  final TourAndTicketBookingStatus statusType;
  const TourBookingDetailsBookingStatus(
      {Key? key,
      required this.bookingStatus,
      this.referenceId,
      this.bookingId,
      this.orderId,
      required this.statusType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _getBookingStatus(
          bookingStatus,
        ),
        if (bookingId != null) const SizedBox(height: kSize8),
        if (bookingId != null)
          _getText(
              getTranslated(context, AppLocalizationsStrings.reservationId),
              bookingId!,
              AppTheme.kBodyMedium),
        if (referenceId != null) const SizedBox(height: kSize4),
        if (referenceId != null)
          _getText(
              getTranslated(context, AppLocalizationsStrings.referenceId),
              referenceId!,
              AppTheme.kSmallMedium.copyWith(color: AppColors.kGrey50)),
        const SizedBox(height: kSize16),
      ],
    );
  }

  Widget _getText(String id, String idNumber, TextStyle textStyle) {
    return RichText(
        text: TextSpan(
            style: textStyle.copyWith(fontFamily: kFontFamily),
            children: [
          TextSpan(text: id.addTrailingColon()),
          TextSpan(text: idNumber)
        ]));
  }

  Widget _getBookingStatus(String bookingStatus) {
    return TourAndTicketBookingDetailHelper.isGradientStatus(statusType)
        ? TourBookingDetailsWithGradient(
            gradientText: bookingStatus,
          )
        : Text(bookingStatus,
            style:
                AppTheme.kBodyMedium.copyWith(color: AppColors.kSystemWrong));
  }
}
