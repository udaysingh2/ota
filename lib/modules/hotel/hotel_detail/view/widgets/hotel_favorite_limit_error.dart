import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kOpacityConstant = 0.4;

class HotelFavoriteMaxLimitError {
  showErrorDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.kBlackOpacity80.withOpacity(_kOpacityConstant),
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: kSize257,
              padding: const EdgeInsets.symmetric(
                horizontal: kSize44,
                vertical: kSize32,
              ),
              decoration: BoxDecoration(
                  color: AppColors.kLoadingBackground,
                  borderRadius: BorderRadius.circular(kSize20),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.kBlackOpacity25,
                      blurRadius: kSize20,
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getTranslated(
                      context,
                      AppLocalizationsStrings.unableToProceed,
                    ),
                    style: AppTheme.kAlertTitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kSize8,
                  ),
                  Text(
                    getTranslated(
                      context,
                      AppLocalizationsStrings.maxLimitExceed,
                    ),
                    style: AppTheme.kBody,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kSize15,
                  ),
                  Material(
                    child: SizedBox(
                      height: kSize36,
                      width: kSize100,
                      child: OtaChipButton(
                        title: getTranslated(
                          context,
                          AppLocalizationsStrings.ok,
                        ),
                        isSelected: true,
                        showShadow: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
