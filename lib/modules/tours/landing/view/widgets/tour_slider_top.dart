import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/tours/landing/bloc/tour_landing_scroll_state_bloc.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_landing_back_navigation_button.dart';

const _kAnimationDuration = 200;
const double _kPaddingOnScreen = 16;
const int _kMaxLines = 1;
const double _kDefaultAppBarHeight = 89;
const String _kSearchIconPath = "assets/images/icons/feather_search.svg";
const double _kSvgPadding = 3;
const double _kOpacity94 = 0.94;

/// As part of OTA-2612 the share button (OTA-120 and OTA-212) functionality
/// will be moved out of MVP 1 scope and will be implemented in MVP-2.
/// Hence all the related code will be commented.

class TourLandingSliderTop extends StatelessWidget {
  final double appBarHeight;
  final Function()? onBackClicked;
  final Function()? onTopSearchClicked;
  final String? statusBarTitle;
  final TourLandingScrollStateBloc tourLandingScrollStateBloc;
  const TourLandingSliderTop({
    Key? key,
    this.appBarHeight = _kDefaultAppBarHeight,
    this.onBackClicked,
    this.onTopSearchClicked,
    this.statusBarTitle,
    required this.tourLandingScrollStateBloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: tourLandingScrollStateBloc,
        builder: () {
          return Container(
            height: appBarHeight - MediaQuery.of(context).padding.top,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: tourLandingScrollStateBloc.state ==
                    TourLandingScrollStateBlocState.hidden
                ? const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.kLight100,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kShadowAppBar,
                        offset: Offset(kSize0, kSize4),
                        blurRadius: kSize4,
                      ),
                    ],
                  )
                : null,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: _kPaddingOnScreen),
                    child: AnimatedSwitcher(
                      duration:
                          const Duration(milliseconds: _kAnimationDuration),
                      child: BlocBuilder(
                        bloc: tourLandingScrollStateBloc,
                        builder: () {
                          return TourLandingBackNavigationButton(
                            onClicked: onBackClicked,
                            removeOval: tourLandingScrollStateBloc.state ==
                                    TourLandingScrollStateBlocState.hidden
                                ? true
                                : false,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: kSize24),
                    child: BlocBuilder(
                      bloc: tourLandingScrollStateBloc,
                      builder: () {
                        return tourLandingScrollStateBloc.state ==
                                TourLandingScrollStateBlocState.hidden
                            ? IconButton(
                                iconSize: kSize24,
                                padding: const EdgeInsets.symmetric(
                                    vertical: _kSvgPadding),
                                icon: SvgPicture.asset(
                                  _kSearchIconPath,
                                  color: AppColors.kGrey70,
                                ),
                                onPressed: onTopSearchClicked,
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                ),
                Center(
                  child: BlocBuilder(
                    bloc: tourLandingScrollStateBloc,
                    builder: () {
                      return Text(
                        statusBarTitle ?? "",
                        maxLines: _kMaxLines,
                        style: AppTheme.kHeading1Medium.copyWith(
                          color: tourLandingScrollStateBloc.state ==
                                  TourLandingScrollStateBlocState.shown
                              ? AppColors.kLight100.withOpacity(_kOpacity94)
                              : AppColors.kGrey70,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
