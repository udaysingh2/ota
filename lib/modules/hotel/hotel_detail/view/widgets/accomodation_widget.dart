import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'icon_text_widget.dart';

const _kLocationIconAsset = "assets/images/icons/travel_location_company.svg";

class AccommodationWidget extends StatelessWidget {
  final String? address;
  const AccommodationWidget({Key? key, required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingHori24Vert16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.accommodationHeader),
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(
            height: kSize16,
          ),
          if (address != null)
            IconTextWidget(
              text: address!,
              iconName: _kLocationIconAsset,
              iconTextGutter: kSize9_33,
              isExpanded: true,
              iconSize: kSize24,
              textStyle:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70),
            ),
        ],
      ),
    );
  }
}
