import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_scroll_state_bloc.dart';

//-- As Per figma
const double _kDefaultPlaceHolderHeight = 219;
const int _kDefaultPlaceAnimationDuration = 200;
const double _kDefaultOpacity = 0.6;

class HotelLandingPlaceHolder extends StatelessWidget {
  const HotelLandingPlaceHolder(
      {Key? key, required this.hotelLandingScrollStateBloc})
      : super(key: key);
  final HotelLandingScrollStateBloc hotelLandingScrollStateBloc;
  @override
  Widget build(BuildContext context) {
    return getBackPlaceHolder();
  }

  Widget getBackPlaceHolder() {
    return BlocBuilder(
        bloc: hotelLandingScrollStateBloc,
        builder: () {
          return AnimatedOpacity(
            opacity: hotelLandingScrollStateBloc.state ==
                    HotelLandingScrollStateBlocState.hidden
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
