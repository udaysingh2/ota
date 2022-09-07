import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double kDividerHeight = 27;
const kSearchErrorImage = "assets/images/icons/no_matching_result_image.svg";

class OtaSearchNoResultWidget extends StatelessWidget {
  final String imageUrl;
  final double dividerHeight;
  final String? errorTextHeader;
  final String? errorTextFooter;
  final double? paddingHeight;

  const OtaSearchNoResultWidget({
    this.imageUrl = kSearchErrorImage,
    this.dividerHeight = kDividerHeight,
    this.errorTextHeader,
    this.errorTextFooter,
    this.paddingHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.kLight100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: kSize24),
                child: SvgPicture.asset(imageUrl)),
            SizedBox(
              height: dividerHeight,
            ),
            Text(
              errorTextHeader ??
                  getTranslated(context, AppLocalizationsStrings.sorry),
              style: AppTheme.kBodyRegular,
            ),
            SizedBox(
              height: paddingHeight ?? 0,
            ),
            Text(
              errorTextFooter ??
                  getTranslated(
                          context, AppLocalizationsStrings.searchErrorText)
                      .replaceAll('\\n', '\n'),
              textAlign: TextAlign.center,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
            ),
          ],
        ),
      ),
    );
  }
}
