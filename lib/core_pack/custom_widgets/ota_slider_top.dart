import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/share_button.dart';

const _kAnimationDuration = 200;
const double _kPaddingOnScreen = 16;
const double _kPaddingOnElement = 8;
const double _kOpacityMax = 1;
const double _kOpacityMin = 0;
const double _kDefaultAppBarHeight = 89;

class OtaSliderTop extends StatelessWidget {
  final double appBarHeight;
  final StatusBarBloc statusBarBloc;
  final Function()? onBackClicked;
  final Function()? onHeartClicked;
  final Function()? onShareClicked;
  final String? statusBarTitle;
  final HeartButtonController? heartButtonController;
  const OtaSliderTop(
      {Key? key,
      this.appBarHeight = _kDefaultAppBarHeight,
      required this.statusBarBloc,
      this.onBackClicked,
      this.statusBarTitle,
      this.onHeartClicked,
      this.heartButtonController,
      this.onShareClicked})
      : super(key: key);
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
                    child: BackNavigationButton(
                      onClicked: onBackClicked,
                      key: ValueKey(statusBarBloc.state.statusBarBlocState !=
                          StatusBarBlocState.opened),
                      removeOval: statusBarBloc.state.statusBarBlocState !=
                          StatusBarBlocState.opened,
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
                        maxLines: 1,
                        style: AppTheme.kBodyMedium,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: _kPaddingOnElement),
                      child: AnimatedSwitcher(
                        duration:
                            const Duration(milliseconds: _kAnimationDuration),
                        child: HeartButton(
                          onClicked: onHeartClicked,
                          heartButtonController: heartButtonController,
                          key: ValueKey(
                              statusBarBloc.state.statusBarBlocState !=
                                  StatusBarBlocState.opened),
                          removeOval: statusBarBloc.state.statusBarBlocState !=
                              StatusBarBlocState.opened,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: _kPaddingOnScreen),
                      child: AnimatedSwitcher(
                        duration:
                            const Duration(milliseconds: _kAnimationDuration),
                        child: ShareButton(
                          onClicked: onShareClicked,
                          key: ValueKey(
                              statusBarBloc.state.statusBarBlocState !=
                                  StatusBarBlocState.opened),
                          removeOval: statusBarBloc.state.statusBarBlocState !=
                              StatusBarBlocState.opened,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
