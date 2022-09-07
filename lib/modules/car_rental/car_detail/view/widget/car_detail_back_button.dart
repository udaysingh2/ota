import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';

const String _kBackArrowIcon = "assets/images/icons/arrow.svg";

class CarDetailBackButton extends StatelessWidget {
  final bool removeBackground;
  final Function()? onClicked;

  const CarDetailBackButton({
    Key? key,
    this.removeBackground = false,
    this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSize40,
      width: kSize40,
      child: removeBackground
          ? _getBackButtonWithoutBackground()
          : _getBackButtonWithBackground(),
    );
  }

  Widget _getBackButtonWithoutBackground() {
    return Material(
      color: Colors.transparent,
      child: _getIconButton(color: AppColors.kGrey70),
    );
  }

  Widget _getBackButtonWithBackground() {
    return Material(
      borderRadius: BorderRadius.circular(kSize20),
      color: AppColors.kGrey70Alpha50,
      child: _getIconButton(color: AppColors.kLight100),
    );
  }

  Widget _getIconButton({required Color color}) {
    return InkWell(
      splashColor: AppColors.kLight100,
      onTap: onClicked,
      borderRadius: BorderRadius.circular(kSize20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize20),
        ),
        child: Center(
          child: SvgPicture.asset(
            _kBackArrowIcon,
            color: color,
          ),
        ),
      ),
    );
  }
}
