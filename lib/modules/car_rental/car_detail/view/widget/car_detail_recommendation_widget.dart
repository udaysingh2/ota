import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxLine = 1;

class CarDetailRecommendation extends StatelessWidget {
  const CarDetailRecommendation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: kSize24, right: kSize24, bottom: kSize24),
          child: Column(
            children: [
              const SizedBox(height: kSize16),
              Text(
                getTranslated(
                    context, AppLocalizationsStrings.recommendedCarRentals),
                style: AppTheme.kHeading1Medium,
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: kSize22),
            ],
          ),
        ),
      ],
    );
  }
}
