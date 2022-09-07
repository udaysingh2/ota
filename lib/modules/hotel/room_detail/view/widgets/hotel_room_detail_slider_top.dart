import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';

import 'hotel_room_back_button.dart';

const _kAnimationDuration = 200;
const double _kPaddingOnScreen = 16;
const double _kPaddingOnElement = 8;
const double _kOpacityMax = 1;
const double _kOpacityMin = 0;
const double _kDefaultAppBarHeight = 89;
const int _kMaxLine = 1;

class HotelSliderTop extends StatelessWidget {
  final double appBarHeight;
  final StatusBarBloc statusBarBloc;
  final Function()? onBackClicked;
  final Function()? onHeartClicked;
  final String? statusBarTitle;
  final HeartButtonController? heartButtonController;
  final bool isRemoveOval;

  const HotelSliderTop({
    Key? key,
    this.appBarHeight = _kDefaultAppBarHeight,
    required this.statusBarBloc,
    required this.isRemoveOval,
    this.onBackClicked,
    this.statusBarTitle,
    this.onHeartClicked,
    this.heartButtonController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight - MediaQuery.of(context).padding.top,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: BlocBuilder(
          bloc: statusBarBloc,
          builder: () {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: _kPaddingOnScreen),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: _kAnimationDuration),
                    child: HotelBackNavigationButton(
                      onClicked: onBackClicked,
                      key: ValueKey(statusBarBloc.state.statusBarBlocState !=
                          StatusBarBlocState.opened),
                      removeOval: isRemoveOval,
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: _kAnimationDuration),
                    opacity: statusBarBloc.state.statusBarBlocState ==
                            StatusBarBlocState.opened
                        ? _kOpacityMin
                        : _kOpacityMax,
                    child: Padding(
                      padding: const EdgeInsets.only(left: _kPaddingOnElement),
                      child: Text(
                        statusBarTitle ?? "",
                        maxLines: _kMaxLine,
                        style: AppTheme.kHBody.copyWith(
                          color: AppColors.kGrey70,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
