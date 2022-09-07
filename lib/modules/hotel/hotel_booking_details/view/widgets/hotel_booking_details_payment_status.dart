import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_gradient_text_with_svg.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/status_type_const.dart';

const int _kMaxLines = 1;

class HotelBookingDetailsPaymentStatus extends StatelessWidget {
  final String paymentStatus;
  const HotelBookingDetailsPaymentStatus({
    Key? key,
    required this.paymentStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.paymentDetails),
          style: AppTheme.kHeading1Medium,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: kSize16,
        ),
        (paymentStatus == PaymentStatusType.failed)
            ? Text(
                getTranslated(
                    context, AppLocalizationsStrings.activityPaymentFailed),
                style: AppTheme.kBodyMedium
                    .copyWith(color: AppColors.kSystemWrong),
              )
            : HotelBookingDetailsWithGradient(
                gradientText: getTranslated(
                    context, AppLocalizationsStrings.paymentStatus),
                isGradientText: false,
              ),
      ],
    );
  }
}
