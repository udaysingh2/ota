import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const String _kCheckBox = "assets/images/icons/checkbox_gradient.svg";

class OtaRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Widget? textWidget;
  final bool circledRadio;
  final bool isCenteredAlign;
  final double iconSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget? selectedWidget;
  final Widget? unSelectedWidget;
  final Widget? disabledWidget;
  final bool isTextFontRegular;
  final Function()? onClicked;
  final CrossAxisAlignment? variableCrossAxisAlignment;

  const OtaRadioButton(
      {Key? key,
      required this.label,
      this.isSelected = false,
      this.textWidget,
      this.circledRadio = false,
      this.isCenteredAlign = false,
      this.iconSize = kSize20,
      this.horizontalPadding = kSize24,
      this.verticalPadding = kSize12,
      this.selectedWidget,
      this.unSelectedWidget,
      this.disabledWidget,
      this.onClicked,
      this.isTextFontRegular = false,
      this.variableCrossAxisAlignment})
      : super(key: key);

  Widget _getButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Ink(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              variableCrossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment: isCenteredAlign
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            _getIcon(context),
            Expanded(child: _getText(context)),
          ],
        ),
      ),
    );
  }

  Widget _getText(BuildContext context) {
    return Ink(
        key: const Key("otaRadioButton"),
        padding: const EdgeInsets.only(left: kSize8),
        child: textWidget ??
            Text(
              label,
              style: isTextFontRegular ? AppTheme.kBodyRegular : AppTheme.kBody,
            ));
  }

  Widget _getIcon(BuildContext context) {
    // Replace containers with svg picture assets when available
    return isSelected
        ? circledRadio
            ? selectedWidget ??
                Ink(
                  height: kSize20,
                  width: kSize20,
                  child: Icon(
                    Icons.radio_button_checked,
                    color: AppColors.kSecondary,
                    size: iconSize,
                  ),
                )
            : disabledWidget ??
                Ink(
                  height: kSize20,
                  width: kSize20,
                  child: SvgPicture.asset(
                    _kCheckBox,
                  ),
                )
        : unSelectedWidget ??
            Ink(
              height: kSize20,
              width: kSize20,
              child: Icon(
                Icons.radio_button_off,
                color: AppColors.kPurpleOutline,
                size: iconSize,
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onClicked, child: _getButton(context));
  }
}
