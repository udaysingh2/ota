import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';

const int _kMaxLine = 2;

class SpecialPromotion extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;

  const SpecialPromotion({
    Key? key,
    required this.carBookingDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int allowLateReturn = carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.allowLateReturn ??
        0;
    if (allowLateReturn < 1) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.specialPromotion),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        Row(
          children: [
            Ink(
              height: kSize20,
              width: kSize20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.kSecondary),
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.kSecondary,
                size: kSize14,
              ),
            ),
            const SizedBox(width: kSize8),
            Text(
              getTranslated(context, AppLocalizationsStrings.free)
                      .addTrailingSpace() +
                  allowLateReturn.toString() +
                  getTranslated(
                      context, AppLocalizationsStrings.hourLateReturn),
              style:
                  AppTheme.kSmallRegular.copyWith(color: AppColors.kSecondary),
            ),
          ],
        ),
        const SizedBox(height: kSize16),
        Text(
          getTranslated(
              context, AppLocalizationsStrings.specialPromotionTermsCondition),
          style: AppTheme.kSmallRegular,
          maxLines: _kMaxLine,
        ),
        const SizedBox(height: kSize24),
      ],
    );
  }
}
