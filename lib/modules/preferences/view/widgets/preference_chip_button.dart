import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class PreferenceChipButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Widget? titleWidget;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final bool showShadow;

  const PreferenceChipButton(
      {Key? key,
      this.title,
      this.onPressed,
      this.isSelected = false,
      this.onSelected,
      this.titleWidget,
      this.showShadow = false})
      : super(key: key);

  Widget _buildButton(BuildContext context) {
    return Ink(
        padding:
            const EdgeInsets.symmetric(horizontal: kSize16, vertical: kSize10),
        decoration: isSelected
            ? BoxDecoration(
                gradient: AppColors.kPurpleGradient,
                borderRadius: kBorderRad20,
                boxShadow: showShadow
                    ? [
                        const BoxShadow(
                          color: AppColors.kBlackOpacity08,
                          blurRadius: kSize8,
                          offset: Offset(kSize0, kSize2),
                        ),
                      ]
                    : [],
                border: Border.all(color: AppColors.kPurpleOutline),
              )
            : BoxDecoration(
                color: AppColors.kTrueWhite,
                borderRadius: kBorderRad20,
                boxShadow: showShadow
                    ? [
                        const BoxShadow(
                          color: AppColors.kBlackOpacity08,
                          blurRadius: kSize8,
                          offset: Offset(kSize0, kSize2),
                        ),
                      ]
                    : [],
                border: Border.all(color: AppColors.kInnerBorderGrey),
              ),
        child: Wrap(
          children: [
            if (titleWidget == null)
              Text(
                title != null ? title! : '',
                style: AppTheme.kBodyRegular.copyWith(
                  color: isSelected ? AppColors.kTrueWhite : AppColors.kGrey70,
                ),
                textAlign: TextAlign.center,
              )
            else
              titleWidget!,
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key("preferenceChipButton"),
      borderRadius: const BorderRadius.all(Radius.circular(kSize20)),
      onTap: onPressed,
      child: _buildButton(context),
    );
  }
}
