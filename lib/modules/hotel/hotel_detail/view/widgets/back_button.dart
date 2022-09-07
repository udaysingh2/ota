import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';

const double _kDefaultSize = 40;
const double _kButtonBorderRadius = 20;

class BackNavigationButton extends StatelessWidget {
  final double height;
  final double width;
  final bool removeOval;
  final double? opacity;
  final Function()? onClicked;
  const BackNavigationButton(
      {this.height = _kDefaultSize,
      this.width = _kDefaultSize,
      this.removeOval = false,
      this.onClicked,
      Key? key,
      this.opacity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(width, height), // button width and height
      child: removeOval ? getRemoveOvalWidget() : getAppliedWidget(),
    );
  }

  Widget getRemoveOvalWidget() {
    return Material(
      color: Colors.transparent, // button color
      child: getIconButton(color: AppColors.kGrey70),
    );
  }

  Widget getAppliedWidget() {
    return Material(
        borderRadius: BorderRadius.circular(_kButtonBorderRadius),
        color: AppColors.kGrey70Alpha50,
        child: getIconButton(color: AppColors.kLight100));
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
            SvgPicture.asset(
              "assets/images/icons/arrow.svg",
              color: color,
            ), // icon // text
          ],
        ),
      ),
    );
  }
}
