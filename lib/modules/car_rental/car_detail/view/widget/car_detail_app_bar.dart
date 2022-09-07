import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_status_bar_bloc.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_controller.dart';

import 'car_detail_back_button.dart';
import 'car_detail_heart_button.dart';
import 'car_detail_share_button.dart';

const int _kAnimationDuration = 200;
const double _kOpacityMax = 1;
const double _kOpacityMin = 0;
const double _kDefaultAppBarHeight = 89;
const int _kMaxLines = 1;

class CarDetailAppBar extends StatelessWidget {
  final CarDetailStatusBarBloc statusBarBloc;
  final Function()? onBackClicked;
  final Function()? onHeartClicked;
  final String? statusBarTitle;
  final HeartButtonCarRentalController? heartButtonCarRentalController;
  final Function()? onShareClicked;
  const CarDetailAppBar(
      {Key? key,
      required this.statusBarBloc,
      this.onBackClicked,
      this.statusBarTitle,
      this.onHeartClicked,
      this.heartButtonCarRentalController,
      this.onShareClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kDefaultAppBarHeight - MediaQuery.of(context).padding.top,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: const EdgeInsets.symmetric(horizontal: kSize16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: _kAnimationDuration),
            child: CarDetailBackButton(
              onClicked: onBackClicked,
              removeBackground: statusBarBloc.state.statusBarBlocState !=
                  CarDetailStatusBarState.opened,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSize8),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: _kAnimationDuration),
                opacity: statusBarBloc.state.statusBarBlocState ==
                        CarDetailStatusBarState.opened
                    ? _kOpacityMin
                    : _kOpacityMax,
                child: Text(
                  statusBarTitle ?? "",
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.kBodyMedium,
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: _kAnimationDuration),
            child: CarDetailHeartButton(
              onClicked: onHeartClicked,
              heartButtonController: heartButtonCarRentalController,
              key: ValueKey(statusBarBloc.state.statusBarBlocState !=
                  CarDetailStatusBarState.opened),
              removeOval: statusBarBloc.state.statusBarBlocState !=
                  CarDetailStatusBarState.opened,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: kSize8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: _kAnimationDuration),
              child: ShareButton(
                onClicked: onShareClicked,
                key: ValueKey(statusBarBloc.state.statusBarBlocState !=
                    CarDetailStatusBarState.opened),
                removeOval: statusBarBloc.state.statusBarBlocState !=
                    CarDetailStatusBarState.opened,
                statusBarBloc: statusBarBloc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
