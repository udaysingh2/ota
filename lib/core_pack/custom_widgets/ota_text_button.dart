import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class OtaTextButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Widget? child;
  final String? buttonURL;
  final bool isSelected;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? fontColor;
  final TextStyle? textStyle;
  final double textHorizontalPadding;
  final Color? splashColor;
  final Color? hoverColor;
  final Color? highlightColor;

  const OtaTextButton(
      {Key? key,
      @required this.title,
      this.onPressed,
      this.child,
      this.buttonURL,
      this.isDisabled = false,
      this.backgroundColor,
      this.fontColor,
      this.textStyle,
      this.textHorizontalPadding = kSize16,
      this.isSelected = true,
      this.highlightColor,
      this.hoverColor,
      this.splashColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppTheme.kBorderRadiusAll24,
        splashColor: splashColor ?? AppColors.kGradientEnd,
        hoverColor: hoverColor ?? AppColors.kGradientEnd,
        highlightColor: highlightColor ?? AppColors.kGradientEnd,
        onTap: isDisabled ? null : onPressed,
        child: Ink(
            padding: EdgeInsets.symmetric(
                horizontal: textHorizontalPadding, vertical: kSize10),
            decoration: backgroundColor == null
                ? isDisabled
                    ? const BoxDecoration(
                        color: AppColors.kGrey10,
                        borderRadius: AppTheme.kBorderRadiusAll24,
                      )
                    : isSelected
                        ? const BoxDecoration(
                            gradient: AppColors.kPurpleGradient,
                            borderRadius: AppTheme.kBorderRadiusAll24,
                          )
                        : const BoxDecoration(
                            color: AppColors.kLight100,
                            borderRadius: AppTheme.kBorderRadiusAll24,
                          )
                : BoxDecoration(
                    color: backgroundColor,
                    borderRadius: AppTheme.kBorderRadiusAll24),
            child: child ??
                Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.kButton3.copyWith(
                      color: fontColor ??
                          (isSelected
                              ? AppColors.kLight100
                              : AppColors.kGradientStart)),
                  textAlign: TextAlign.center,
                )),
      ),
    );
  }
}
