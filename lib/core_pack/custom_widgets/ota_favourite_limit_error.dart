import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kOpacityConstant = 0.4;

class OtaFavoriteMaxLimitError {
  String? _errorTitle;
  String? _errorMessage;
  String? _btnText;
  showErrorDialog(BuildContext context,
      {String? errorTitle, String? errorMessage, String? btnText}) {
    _errorTitle = errorTitle;
    _errorMessage = errorMessage;
    _btnText = btnText;
    showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.kBlackOpacity80.withOpacity(_kOpacityConstant),
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: kSize304,
              padding: const EdgeInsets.symmetric(
                horizontal: kSize24,
                vertical: kSize24,
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
                  if (_errorTitle != null)
                    Text(
                      _errorTitle!,
                      style: AppTheme.kHeading1Medium,
                      textAlign: TextAlign.center,
                    ),
                  if (_errorTitle == null)
                    Text(
                      getTranslated(
                        context,
                        AppLocalizationsStrings.unableToProceed,
                      ),
                      style: AppTheme.kHeading1Medium,
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(
                    height: kSize8,
                  ),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: AppTheme.kSmallRegular
                          .copyWith(color: AppColors.kGrey50),
                      textAlign: TextAlign.center,
                    ),
                  if (_errorMessage == null)
                    Text(
                      getTranslated(
                        context,
                        AppLocalizationsStrings.maxLimitExceed,
                      ),
                      style: AppTheme.kSmallRegular
                          .copyWith(color: AppColors.kGrey50),
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
                        title: _getButtonText(context),
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

  String _getButtonText(context) {
    String text;
    if (_btnText != null) {
      text = _btnText!;
    } else {
      text = getTranslated(
        context,
        AppLocalizationsStrings.ok,
      );
    }
    return text;
  }
}
