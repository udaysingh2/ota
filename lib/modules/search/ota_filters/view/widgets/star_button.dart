import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kButtonDefaultHeight = 24;
const double _kPaddingHorizontal = 8;
const EdgeInsets _kPaddingAround = EdgeInsets.symmetric(
  horizontal: _kPaddingHorizontal,
);
const double _kStarTextSpacing = 4;
const double _kStarSize = 16;
const double _kButtonBorderRadius = 20;
const String _kStarImageAsset = "assets/images/icons/star.svg";
const double _kStarTopSpacing = -0.5;

class StarButton extends StatelessWidget {
  final String buttonText;
  final Function()? onRatingClicked;
  final bool isSelected;
  const StarButton(
      {Key? key,
      required this.buttonText,
      this.onRatingClicked,
      this.isSelected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(_kButtonBorderRadius),
      onTap: onRatingClicked,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kButtonBorderRadius),
            gradient: isSelected ? AppColors.kPurpleGradient : null,
            color: isSelected ? null : AppColors.kGrey4),
        height: _kButtonDefaultHeight,
        padding: _kPaddingAround,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              _kStarImageAsset,
              height: _kStarSize,
              width: _kStarSize,
            ),
            const SizedBox(
              width: _kStarTextSpacing,
            ),
            Container(
              transform:
                  Matrix4.translationValues(kSize0, _kStarTopSpacing, kSize0),
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: isSelected
                    ? AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kLight100)
                    : AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
