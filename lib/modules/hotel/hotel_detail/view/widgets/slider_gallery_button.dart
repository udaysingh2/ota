import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kPaddingHorizontal = 8;
const double _kButtonBorderRadius = 20;
const double _kBackgroundOpacity = 0.94;

class SliderGalleryButton extends StatelessWidget {
  final String buttonText;
  final Function()? onRatingClicked;
  const SliderGalleryButton(
      {Key? key, required this.buttonText, this.onRatingClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(_kButtonBorderRadius),
      onTap: onRatingClicked,
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kButtonBorderRadius),
            color: AppColors.kLight100.withOpacity(_kBackgroundOpacity)),
        padding: const EdgeInsets.symmetric(
          horizontal: _kPaddingHorizontal,
          vertical: kSize4,
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: AppTheme.kSmallRegular,
        ),
      ),
    );
  }
}
