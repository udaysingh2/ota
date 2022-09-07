import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_pack/custom_widgets/ota_oval_button.dart';

const double _kDefaultSize = 40;
const double _kButtonBorderRadius = 20;
const String _kShareButtonAsset = 'assets/images/icons/share_button.svg';

class ShareButton extends StatelessWidget {
  final double height;
  final double width;
  final bool removeOval;
  final Color? buttonColor;
  final Function()? onClicked;
  const ShareButton(
      {this.height = _kDefaultSize,
      this.width = _kDefaultSize,
      this.removeOval = false,
      this.onClicked,
      this.buttonColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(width, height), // button width and height
      child: removeOval ? getRemoveOvalWidget() : getAppliedOvalWidget(),
    );
  }

  Widget getRemoveOvalWidget() {
    return Material(
      color: Colors.transparent,
      child: onClicked == null
          ? getIconButton(color: AppColors.kLoadingText)
          : getIconButton(color: Colors.black),
    );
  }

  Widget getAppliedOvalWidget() {
    return OtaOvalButton(
      iconSvgPath: "assets/images/icons/share_button.svg",
      onClick: onClicked,
      ovalColor: buttonColor ?? AppColors.kLight100Alpha50,
      ovalIconColor: onClicked == null ? AppColors.kLoadingText : Colors.black,
    );
  }

  Widget getIconButton({Color color = AppColors.kLight100}) {
    return InkWell(
      splashColor: AppColors.kLight100,
      // splash color
      onTap: onClicked,
      // button pressed
      borderRadius: BorderRadius.circular(_kButtonBorderRadius),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kButtonBorderRadius)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(_kShareButtonAsset, color: color), // icon // text
            // icon // text
          ],
        ),
      ),
    );
  }
}
