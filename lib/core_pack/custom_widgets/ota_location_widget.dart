import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'ota_gradient_text_widget.dart';

class OtaLocationWidget extends StatelessWidget {
  final String locationText;
  final Function()? onTap;
  final TextStyle? style;
  final String leadingIcon;
  final String? trailingIcon;
  final bool isEnabled;
  final bool isGradientText;
  final double? paddingWidth;

  const OtaLocationWidget({
    required this.locationText,
    required this.style,
    required this.leadingIcon,
    this.trailingIcon,
    this.onTap,
    this.isEnabled = true,
    this.isGradientText = false,
    this.paddingWidth = 5,
    Key? key,
  }) : super(key: key);
  Widget _getRow() {
    return Row(
      children: [
        SvgPicture.asset(leadingIcon),
        SizedBox(width: paddingWidth),
        isGradientText
            ? OtaGradientText(
                gradientText: locationText,
                gradientTextStyle: AppTheme.kBodyRegular,
                textGradientStartColor: AppColors.kGradientStart,
                textGradientEndColor: AppColors.kGradientEnd,
                gradientTextBegin: Alignment.bottomCenter,
                gradientTextEnd: Alignment.topLeft,
              )
            : Text(locationText, style: style),
        SizedBox(width: paddingWidth),
        if (trailingIcon != null) SvgPicture.asset(trailingIcon!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isEnabled ? InkWell(onTap: onTap, child: _getRow()) : _getRow();
  }
}
