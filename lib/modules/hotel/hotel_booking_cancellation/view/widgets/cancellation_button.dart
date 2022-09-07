import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class CancellationButton extends StatelessWidget {
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

  const CancellationButton({
    Key? key,
    @required this.title,
    this.onPressed,
    this.child,
    this.buttonURL,
    this.isDisabled = false,
    this.backgroundColor,
    this.fontColor,
    this.textStyle,
    this.textHorizontalPadding = kSize23,
    this.isSelected = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppTheme.kBorderRadiusAll24,
        onTap: isDisabled ? null : onPressed,
        child: Ink(
            padding: EdgeInsets.symmetric(
                horizontal: textHorizontalPadding, vertical: kSize10),
            decoration: isDisabled
                ? const BoxDecoration(
                    color: AppColors.kGrey10,
                    borderRadius: AppTheme.kBorderRadiusAll24,
                  )
                : isSelected
                    ? BoxDecoration(
                        color: backgroundColor,
                        borderRadius: AppTheme.kBorderRadiusAll24)
                    : const BoxDecoration(
                        color: AppColors.kLight100,
                        borderRadius: AppTheme.kBorderRadiusAll24,
                      ),
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
