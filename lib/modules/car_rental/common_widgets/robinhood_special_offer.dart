import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'free_food_delivery_widget.dart';

class RobinhoodSpecialOffer extends StatelessWidget {
  final String? title;
  final String? description;
  final String urlString;
  final bool showHorizontalDivider;

  const RobinhoodSpecialOffer({
    Key? key,
    this.title,
    this.description,
    this.urlString = '',
    this.showHorizontalDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHorizontalDivider)
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
          ),
        if (showHorizontalDivider) const SizedBox(height: kSize24),
        Text(
          getTranslated(
              context, AppLocalizationsStrings.carRobinhoodSpecialOffer),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        FreeFoodDeliveryWidget(
            urlString: urlString, title: title, description: description),
        const SizedBox(height: kSize24),
      ],
    );
  }
}
