import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double kpaddingLeft = 12.0;
const double kpaddingTopRightBottom = 11.0;
const double kDefaultBorderRadius = 8.0;

class DropDownMenuButton extends StatelessWidget {
  final String buttonText;
  final String buttonIcon;
  final void Function()? onButtonPressed;
  final double borderRadius;
  const DropDownMenuButton({
    Key? key,
    this.buttonText = "",
    this.buttonIcon = "assets/images/icons/chevron_down.svg",
    this.borderRadius = kDefaultBorderRadius,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onButtonPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.kGrey20,
        primary: AppColors.kGrey70,
        padding: const EdgeInsets.only(
            left: kpaddingLeft,
            top: kpaddingTopRightBottom,
            bottom: kpaddingTopRightBottom,
            right: kpaddingTopRightBottom),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: const BorderSide(color: AppColors.kLight100, width: kSize1),
        ),
      ),
      child: Row(
        children: [
          Text(
            buttonText,
            style: AppTheme.kBody,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SvgPicture.asset(buttonIcon),
        ],
      ),
    );
  }
}
