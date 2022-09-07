import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/common_widgets/car_rental_late_return_text_widget.dart';

import 'ota_horizontal_divider.dart';

const int _kMaxLine = 4;

class OtaSpecialPromotionWidget extends StatelessWidget {
  final int allowLateReturn;
  const OtaSpecialPromotionWidget({
    Key? key,
    this.allowLateReturn = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        CarRentalLateReturnTextWidget(allowLateReturn: allowLateReturn),
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
