import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';

const double _kWidth = 304;

class OtaAlertDialog {
  final String errorTitle;
  final String errorMessage;
  final String buttonTitle;
  final bool button2;
  final String? button2Title;
  final EdgeInsetsGeometry padding;
  final Function()? onPressed;
  final Function()? onPressedButton2;
  final bool useRootNavigator;
  const OtaAlertDialog({
    this.errorTitle = '',
    this.errorMessage = '',
    this.buttonTitle = '',
    this.onPressed,
    this.button2 = false,
    this.button2Title = '',
    this.padding = kPaddingAll24,
    this.onPressedButton2,
    this.useRootNavigator = true,
  });

  Future<void> showAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: useRootNavigator,
        barrierColor: Colors.black.withOpacity(0.4),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              backgroundColor: AppColors.kLight100,
              elevation: kSize0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kSize20),
              ), //this right here
              child: SizedBox(
                width: _kWidth,
                child: Padding(
                  padding: padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorTitle,
                        style: AppTheme.kHeading1Medium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: kSize8,
                      ),
                      Text(
                        errorMessage,
                        style: AppTheme.kSmallRegular
                            .copyWith(color: AppColors.kGrey50),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: kSize24,
                      ),
                      !button2
                          ? SizedBox(
                              height: kSize44,
                              width: kSize120,
                              child: OtaChipButton(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(kSize24)),
                                titleWidget: Center(
                                  child: Text(
                                    buttonTitle,
                                    style: AppTheme.kButton
                                        .copyWith(color: AppColors.kLight100),
                                  ),
                                ),
                                isSelected: true,
                                showShadow: false,
                                onPressed: onPressed ??
                                    () {
                                      Navigator.of(context).pop();
                                    },
                              ),
                            )
                          : Row(
                              children: [
                                SizedBox(
                                  height: kSize44,
                                  width: kSize120,
                                  child: OtaChipButton(
                                    titleWidget: Center(
                                      child: OtaGradientText(
                                        gradientText: buttonTitle,
                                        gradientTextStyle: AppTheme.kButton,
                                        textGradientStartColor:
                                            AppColors.kGradientStart,
                                        textGradientEndColor:
                                            AppColors.kGradientEnd,
                                      ),
                                    ),
                                    isSelected: false,
                                    showShadow: false,
                                    buttonBackgroundColor: Colors.transparent,
                                    onPressed: onPressed ??
                                        () {
                                          Navigator.of(context).pop();
                                        },
                                  ),
                                ),
                                const SizedBox(
                                  width: kSize16,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: kSize44,
                                    width: kSize120,
                                    child: OtaChipButton(
                                      titleWidget: Center(
                                        child: Text(
                                          button2Title!,
                                          style: AppTheme.kButton.copyWith(
                                              color: AppColors.kLight100),
                                        ),
                                      ),
                                      isSelected: true,
                                      showShadow: false,
                                      onPressed: onPressedButton2 ??
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
