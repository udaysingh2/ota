import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_model.dart';

const double _kDefaultSize = 40;
const double _kButtonBorderRadius = 20;

class HeartButton extends StatelessWidget {
  final double height;
  final double width;
  final bool removeOval;
  final Color? buttonColor;
  final Function()? onClicked;
  final HeartButtonController? heartButtonController;

  const HeartButton({
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
          ? getRemoveOvalWidget(height: kSize16, width: kSize19)
          : getAppliedOvalWidget(height: kSize21, width: kSize24),
    );
  }

  Widget getRemoveOvalWidget({required double height, required double width}) {
    return Material(
      color: Colors.transparent, // button color
      child:
          getIconButton(color: AppColors.kGrey70, height: height, width: width),
    );
  }

  Widget getAppliedOvalWidget({required double height, required double width}) {
    return ClipOval(
      child: Material(
        color: buttonColor ?? AppColors.kLight100Alpha50, // button color
        child: getIconButton(height: height, width: width),
      ),
    );
  }

  Widget getIconButton(
      {Color color = AppColors.kLight100,
      required double height,
      required double width}) {
    return BlocBuilder(
        bloc: heartButtonController ?? HeartButtonController(),
        builder: () {
          return InkWell(
            splashColor: AppColors.kLight100,
            // splash color
            onTap: (heartButtonController?.state.heartButtonState ==
                    HeartButtonState.disabled)
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
                child: getHeartIconSvg(
                    color, heartButtonController ?? HeartButtonController(),
                    height: height, width: width),
              ),
            ),
          );
        });
  }

  Widget getHeartIconSvg(
      Color color, HeartButtonController heartButtonController,
      {required double height, required double width}) {
    String asset = '';
    switch (heartButtonController.state.heartButtonState) {
      case HeartButtonState.disabled:
        asset = "assets/images/icons/heart_disabled.svg";
        break;
      case HeartButtonState.selected:
        asset = "assets/images/icons/heart_selected.svg";
        break;
      case HeartButtonState.unselected:
        asset = "assets/images/icons/heart_unselected.svg";
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
