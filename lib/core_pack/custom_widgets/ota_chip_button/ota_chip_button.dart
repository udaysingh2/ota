import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kBorderRadius20 = BorderRadius.all(Radius.circular(kSize20));
const _maxLines = 1;

class OtaChipButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Widget? titleWidget;
  final bool isSelected;
  final double? height;
  final ValueChanged<bool>? onSelected;
  final bool showShadow;
  final bool isGreybackground;
  final bool isLighterGreyColor;
  final Color? buttonBackgroundColor;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;

  const OtaChipButton(
      {Key? key,
      this.title = "",
      this.onPressed,
      this.isSelected = true,
      this.onSelected,
      this.titleWidget,
      this.height,
      this.showShadow = false,
      this.isGreybackground = true,
      this.isLighterGreyColor = false,
      this.buttonBackgroundColor,
      this.padding = const EdgeInsets.symmetric(horizontal: kSize8),
      this.borderRadius})
      : super(key: key);

  Widget _buildButton(BuildContext context) {
    return Ink(
      padding: padding,
      decoration: isSelected
          ? BoxDecoration(
              gradient: AppColors.kPurpleGradient,
              borderRadius: borderRadius ?? _kBorderRadius20,
              boxShadow: showShadow
                  ? [
                      const BoxShadow(
                        color: AppColors.kButtonShadowLight,
                        spreadRadius: kSize2,
                        blurRadius: kSize2,
                      ),
                    ]
                  : [],
            )
          : BoxDecoration(
              color: buttonBackgroundColor ?? _getGreyBackgroundColor(),
              borderRadius: borderRadius ?? _kBorderRadius20,
              boxShadow: showShadow
                  ? [
                      const BoxShadow(
                        color: AppColors.kButtonShadowLight,
                        spreadRadius: kSize2,
                        blurRadius: kSize2,
                      ),
                    ]
                  : [],
            ),
      child: SizedBox(
        height: height,
        child: Center(
          child: titleWidget ??
              Text(
                title,
                style: AppTheme.kSmallRegular.copyWith(
                  color: isSelected ? AppColors.kTrueWhite : AppColors.kGrey50,
                ),
                textAlign: TextAlign.center,
                maxLines: _maxLines,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
    );
  }

  Color _getGreyBackgroundColor() {
    return isGreybackground
        ? isLighterGreyColor
            ? AppColors.kGrey4
            : AppColors.kGrey10
        : AppColors.kLight100;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key("otaChipButton"),
      borderRadius: const BorderRadius.all(Radius.circular(kSize20)),
      onTap: onPressed,
      child: _buildButton(context),
    );
  }
}
