import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/scb_easy_helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class SCBAlertDialog {
  Future<SCBEasyAppState?> showAlertDialog(BuildContext context) async {
    return await showDialog<SCBEasyAppState?>(
        context: context,
        barrierDismissible: false,
        barrierColor: AppColors.kBlackOpacity40,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.kLight100,
            elevation: kSize0,
            shape: const RoundedRectangleBorder(
              borderRadius: AppTheme.kBorderRadiusAll20,
            ),
            child: Padding(
              padding: const EdgeInsets.all(kSize24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getTranslated(
                        context, AppLocalizationsStrings.scbDialogTitle),
                    style: AppTheme.kHeading1Medium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: kSize8),
                  Text(
                    getTranslated(
                        context, AppLocalizationsStrings.scbDialogSubtitle),
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kGrey50),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: kSize24),
                  SizedBox(
                    height: kSize44,
                    child: OtaChipButton(
                      titleWidget: Center(
                        child: Text(
                          getTranslated(
                            context,
                            AppLocalizationsStrings.scbDialogInstall,
                          ),
                          style: AppTheme.kButton3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      isSelected: true,
                      showShadow: false,
                      onPressed: () {
                        Navigator.of(context).pop<SCBEasyAppState>(
                          SCBEasyAppState.installInitiated,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: kSize16),
                  SizedBox(
                    height: kSize44,
                    child: OtaChipButton(
                      titleWidget: Center(
                        child: OtaGradientText(
                          gradientText: getTranslated(
                            context,
                            AppLocalizationsStrings.scbDialogOtherSelection,
                          ),
                          gradientTextStyle: AppTheme.kButton3.copyWith(
                            color: AppColors.kPrimaryHighlight,
                          ),
                          textGradientStartColor: AppColors.kGradientStart,
                          textGradientEndColor: AppColors.kGradientEnd,
                        ),
                      ),
                      isSelected: false,
                      showShadow: false,
                      isGreybackground: false,
                      onPressed: () {
                        Navigator.of(context).pop<SCBEasyAppState>(
                          SCBEasyAppState.anotherPaymentSelected,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: kSize24),
                  Text(
                    getTranslated(
                        context, AppLocalizationsStrings.scbDialogFooterTitle),
                    style: AppTheme.kSmallerRegular
                        .copyWith(color: AppColors.kGrey50),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
