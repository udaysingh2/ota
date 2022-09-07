import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kButtonDefaultHeight = 29;
const EdgeInsets _kPaddingAround =
    EdgeInsets.symmetric(horizontal: kSize8, vertical: kSize4);
const double _kButtonBorderRadius = 20;

class PromotionsButton extends StatelessWidget {
  final String buttonText;
  final Function()? onButtonClicked;
  final bool isSelected;
  const PromotionsButton(
      {Key? key,
      required this.buttonText,
      this.onButtonClicked,
      this.isSelected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(_kButtonBorderRadius),
      onTap: onButtonClicked,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kButtonBorderRadius),
            gradient: isSelected ? AppColors.kPurpleGradient : null,
            color: isSelected ? null : AppColors.kGrey4),
        height: _kButtonDefaultHeight,
        padding: _kPaddingAround,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: isSelected
              ? AppTheme.kSmallRegular.copyWith(color: AppColors.kLight100)
              : AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
        ),
      ),
    );
  }
}
