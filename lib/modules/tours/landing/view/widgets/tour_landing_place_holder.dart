import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/tours/landing/bloc/tour_landing_scroll_state_bloc.dart';

//-- As Per figma
const double _kDefaultPlaceHolderHeight = 219;
const int _kDefaultPlaceAnimationDuration = 200;
const double _kDefaultOpacity = 0.6;

class TourLandingPlaceHolder extends StatelessWidget {
  const TourLandingPlaceHolder(
      {Key? key, required this.tourLandingScrollStateBloc})
      : super(key: key);
  final TourLandingScrollStateBloc tourLandingScrollStateBloc;
  @override
  Widget build(BuildContext context) {
    return getBackPlaceHolder();
  }

  Widget getBackPlaceHolder() {
    return BlocBuilder(
        bloc: tourLandingScrollStateBloc,
        builder: () {
          return AnimatedOpacity(
            opacity: tourLandingScrollStateBloc.state ==
                    TourLandingScrollStateBlocState.hidden
                ? 0
                : 1,
            duration:
                const Duration(milliseconds: _kDefaultPlaceAnimationDuration),
            child: Opacity(
              opacity: _kDefaultOpacity,
              child: Container(
                height: _kDefaultPlaceHolderHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: AppColors.gradient1,
                ),
              ),
            ),
          );
        });
  }
}
