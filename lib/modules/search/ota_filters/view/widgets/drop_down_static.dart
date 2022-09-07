import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';

const double _kButtonDefaultHeight = 42;
const double _kButtonBorderRadius = 8;
const EdgeInsets _kPadding = EdgeInsets.symmetric(horizontal: 12);
const double _kSvgImage = 20;
const String _kChevronDown = "assets/images/icons/chevron_down.svg";

class DropDownStatic extends StatelessWidget {
  final String buttonText;
  final Function()? onRatingClicked;
  const DropDownStatic({
    Key? key,
    required this.buttonText,
    this.onRatingClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(_kButtonBorderRadius),
      onTap: onRatingClicked,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kButtonBorderRadius),
          color: AppColors.kGrey4,
        ),
        height: _kButtonDefaultHeight,
        padding: _kPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                buttonText,
                style: AppTheme.kBodyRegular,
              ),
            ),
            SvgPicture.asset(
              _kChevronDown,
              width: _kSvgImage,
              height: _kSvgImage,
              color: AppColors.kGrey70,
            ),
          ],
        ),
      ),
    );
  }
}
