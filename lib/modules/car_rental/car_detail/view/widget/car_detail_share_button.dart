import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_status_bar_bloc.dart';

const double _kDefaultSize = 40;
const double _kButtonBorderRadius = 20;
const String _kImagePath = "assets/images/icons/share_button.svg";

class ShareButton extends StatelessWidget {
  final double height;
  final double width;
  final bool removeOval;
  final Color? buttonColor;
  final Function()? onClicked;
  final CarDetailStatusBarBloc statusBarBloc;
  const ShareButton(
      {this.height = _kDefaultSize,
      this.width = _kDefaultSize,
      this.removeOval = false,
      this.onClicked,
      this.buttonColor,
      required this.statusBarBloc,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(width, height), // button width and height
      child: removeOval
          ? getRemoveOvalWidget(height: kSize19, width: kSize19)
          : getOvalWidget(height: kSize24, width: kSize24),
    );
  }

  Widget getRemoveOvalWidget({required double height, required double width}) {
    return Material(
      color: Colors.transparent,
      child: onClicked == null
          ? getIconButton(height: height, width: width)
          : getIconButton(height: height, width: width),
    );
  }

  Widget getOvalWidget({required double height, required double width}) {
    return ClipOval(
      child: Material(
        color: buttonColor ?? AppColors.kLight100Alpha50,
        child: getIconButton(height: height, width: width), // button color
      ),
    );
  }

  Widget getIconButton(
      {Color color = AppColors.kLight100,
      required double height,
      required double width}) {
    return BlocBuilder(
        bloc: statusBarBloc,
        builder: () {
          return InkWell(
            splashColor: AppColors.kLight100,
            onTap: (statusBarBloc.state.shareButtonState ==
                    ShareButtonState.disable)
                ? null
                : onClicked,
            // button pressed
            borderRadius: BorderRadius.circular(_kButtonBorderRadius),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_kButtonBorderRadius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    _kImagePath,
                    color: _setColor(statusBarBloc),
                    height: height,
                    width: width,
                    fit: BoxFit.contain,
                  ), // icon // text
                ],
              ),
            ),
          );
        });
  }

  _setColor(CarDetailStatusBarBloc statusBarBloc) {
    if (statusBarBloc.state.shareButtonState == ShareButtonState.disable) {
      return AppColors.kGrey20;
    } else {
      return AppColors.kGrey70;
    }
  }
}
