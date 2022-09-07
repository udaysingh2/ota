import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';

class OtaOvalButton extends StatelessWidget {
  final String? iconSvgPath;
  final Function()? onClick;
  final Color? ovalColor;
  final Color ovalIconColor;
  final double? height;
  final double? width;
  const OtaOvalButton({
    Key? key,
    this.iconSvgPath,
    this.onClick,
    this.ovalColor,
    this.height = 24,
    this.width = 24,
    this.ovalIconColor = AppColors.kLight100,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getOvalWidget();
  }

  Widget getOvalWidget() {
    return ClipOval(
      child: Material(
        color: ovalColor ?? AppColors.kGrey70Alpha50, // button color
        child: getIconButton(),
      ),
    );
  }

  Widget getIconButton() {
    return InkWell(
      splashColor: AppColors.kLight100,
      // splash color
      onTap: onClick,
      // button pressed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            iconSvgPath ?? "assets/images/icons/arrow.svg",
            color: ovalIconColor,
            height: height,
            width: width,
          ), // icon // text
        ],
      ),
    );
  }
}
