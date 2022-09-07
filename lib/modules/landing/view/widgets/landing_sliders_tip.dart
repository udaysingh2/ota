import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/landing/bloc/status_bar_bloc.dart';

const double _kDefaultWidth = 40;
const double _kDefaultHeight = 4;
const double _kDefaultCornerRadius = 2;

class LandingSlidersTip extends StatelessWidget {
  const LandingSlidersTip({Key? key, required this.statusBarBloc})
      : super(key: key);
  final StatusBarBloc statusBarBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: statusBarBloc,
        builder: () {
          if (statusBarBloc.state.statusBarBlocState ==
              StatusBarBlocState.opened) {
            return Container(
              width: _kDefaultWidth,
              height: _kDefaultHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_kDefaultCornerRadius),
                  color: AppColors.kGrey4),
            );
          }
          return const SizedBox();
        });
  }
}
