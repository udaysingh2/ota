import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';

const double kWidth = 186;
const double kSpacing7 = 7;
const EdgeInsetsGeometry _kDefaultPadding = EdgeInsets.all(kSize32);

class OtaAlertOverlay {
  final String errorTitle;
  final String errorMessage;
  final String buttonTitle;
  final bool button2;
  final String? button2Title;
  final EdgeInsetsGeometry padding;
  final Function()? onPressed;
  final Function()? onPressedButton2;
  OtaAlertOverlay({
    this.errorTitle = '',
    this.errorMessage = '',
    this.buttonTitle = '',
    this.onPressed,
    this.button2 = false,
    this.button2Title = '',
    this.padding = _kDefaultPadding,
    this.onPressedButton2,
  });

  OverlayEntry showAlertOverlay(BuildContext context) {
    final horizontalMargin = MediaQuery.of(context).size.width * 0.3 / 2;
    final verticalMargin = MediaQuery.of(context).size.height * 0.7 / 2;
    OverlayState? alertOverlayState = Overlay.of(context);
    OverlayEntry? alertOverlayEntry;
    alertOverlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          color: AppColors.kBlackOpacity50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kSize20),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: horizontalMargin, vertical: verticalMargin),
              decoration: BoxDecoration(
                color: AppColors.kLight100,
                borderRadius: BorderRadius.circular(kSize20),
              ),
              width: kWidth,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorTitle,
                        style: AppTheme.kAlertTitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: kSpacing7,
                      ),
                      Text(
                        errorMessage,
                        style: AppTheme.kHeading5
                            .copyWith(color: AppColors.kGrey77),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: kSize15,
                      ),
                      !button2
                          ? SizedBox(
                              height: kSize36,
                              width: kSize100,
                              child: OtaChipButton(
                                titleWidget: Center(
                                  child: Text(
                                    buttonTitle,
                                    style: AppTheme.kSmall1
                                        .copyWith(color: AppColors.kLight100),
                                  ),
                                ),
                                isSelected: true,
                                showShadow: true,
                                onPressed: onPressed ??
                                    () {
                                      alertOverlayEntry?.remove();
                                    },
                              ),
                            )
                          : Row(
                              children: [
                                SizedBox(
                                  height: kSize36,
                                  width: kSize100,
                                  child: OtaChipButton(
                                    titleWidget: Center(
                                      child: OtaGradientText(
                                        gradientText: buttonTitle,
                                        gradientTextStyle: AppTheme.kSmall1,
                                        textGradientStartColor:
                                            AppColors.kGradientStart,
                                        textGradientEndColor:
                                            AppColors.kGradientEnd,
                                      ),
                                    ),
                                    isSelected: false,
                                    showShadow: true,
                                    onPressed: onPressed ??
                                        () {
                                          alertOverlayEntry?.remove();
                                        },
                                  ),
                                ),
                                const SizedBox(
                                  width: kSize20,
                                ),
                                SizedBox(
                                  height: kSize36,
                                  width: kSize100,
                                  child: OtaChipButton(
                                    titleWidget: Center(
                                      child: Text(
                                        button2Title!,
                                        style: AppTheme.kSmall1.copyWith(
                                            color:
                                                AppColors.kLoadingBackground),
                                      ),
                                    ),
                                    isSelected: true,
                                    showShadow: true,
                                    onPressed: onPressedButton2 ??
                                        () {
                                          alertOverlayEntry?.remove();
                                        },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    alertOverlayState?.insert(alertOverlayEntry);
    return alertOverlayEntry;
  }
}
