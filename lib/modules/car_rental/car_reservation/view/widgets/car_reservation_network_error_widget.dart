import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double kDividerHeight = 27;

class OtaCarReservationNetworkErrorWidget extends StatelessWidget {
  final String imageUrl;
  final String? errorTextHeader;
  final String? errorTextFooter;

  const OtaCarReservationNetworkErrorWidget({
    this.imageUrl = "assets/images/icons/network_error_image.svg",
    this.errorTextHeader,
    this.errorTextFooter,
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
            SvgPicture.asset(imageUrl),
            const SizedBox(
              height: kDividerHeight,
            ),
            Text(
                errorTextHeader ??
                    getTranslated(context,
                        AppLocalizationsStrings.carErrorInfoNotAvailable),
                style: AppTheme.kBodyRegular),
            Text(
              errorTextFooter ??
                  getTranslated(
                      context, AppLocalizationsStrings.pleasePullToRefresh),
              textAlign: TextAlign.center,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
            ),
          ],
        ),
      ),
    );
  }
}
