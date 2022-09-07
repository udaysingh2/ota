import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_controller.dart';

import 'heart_button_car_rental_model.dart';

const double _kDefaultSize = 40;
const double _kButtonBorderRadius = 20;
const String _kDisabled = "assets/images/icons/heart_disabled.svg";
const String _kSelected = "assets/images/icons/heart_selected.svg";
const String _kUnselected = "assets/images/icons/heart_unselected.svg";

class CarDetailHeartButton extends StatelessWidget {
  final double height;
  final double width;
  final bool removeOval;
  final Color? buttonColor;
  final Function()? onClicked;
  final HeartButtonCarRentalController? heartButtonController;
  const CarDetailHeartButton({
    this.height = _kDefaultSize,
    this.width = _kDefaultSize,
    this.removeOval = false,
    this.onClicked,
    this.heartButtonController,
    this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(width, height), // button width and height
      child: removeOval
          ? _getHeartButtonWithoutBackground(height: kSize16, width: kSize19)
          : _getHeartButtonWithBackground(height: kSize21, width: kSize24),
    );
  }

  Widget _getHeartButtonWithoutBackground(
      {required double height, required double width}) {
    return Material(
      color: Colors.transparent, // button color
      child: _getIconButton(
          color: AppColors.kGrey70, height: height, width: width),
    );
  }

  Widget _getHeartButtonWithBackground(
      {required double height, required double width}) {
    return ClipOval(
      child: Material(
        color: buttonColor ?? AppColors.kLight100Alpha50, // button color
        child: _getIconButton(height: height, width: width),
      ),
    );
  }

  Widget _getIconButton(
      {Color color = AppColors.kLight100,
      required double height,
      required double width}) {
    return BlocBuilder(
        bloc: heartButtonController ?? HeartButtonCarRentalController(),
        builder: () {
          return InkWell(
            splashColor: AppColors.kLight100,
            // splash color
            onTap: (heartButtonController?.state.heartButtonCarRentalState ==
                    HeartButtonCarRentalState.disabled)
                ? null
                : onClicked,
            // button pressed
            borderRadius: BorderRadius.circular(_kButtonBorderRadius),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_kButtonBorderRadius),
              ),
              child: AnimatedSwitcher(
                duration: kDuration275,
                child: _getHeartIconSvg(color,
                    heartButtonController ?? HeartButtonCarRentalController(),
                    height: height, width: width),
              ),
            ),
          );
        });
  }

  Widget _getHeartIconSvg(Color color,
      HeartButtonCarRentalController heartButtonCarRentalController,
      {required double height, required double width}) {
    String asset = '';
    switch (heartButtonCarRentalController.state.heartButtonCarRentalState) {
      case HeartButtonCarRentalState.disabled:
        asset = _kDisabled;
        break;
      case HeartButtonCarRentalState.selected:
        asset = _kSelected;
        break;
      case HeartButtonCarRentalState.unselected:
        asset = _kUnselected;
        break;
    }
    return SvgPicture.asset(
      asset,
      height: height,
      width: width,
      fit: BoxFit.contain,
      key: Key(asset),
    );
  }
}
