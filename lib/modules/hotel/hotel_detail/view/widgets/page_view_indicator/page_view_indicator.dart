import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/page_view_indicator/page_view_indicator_bloc.dart';

const kExpandingAnimationDuration = 200;
const double _kExpandedWidth = 24;
const double _kCollapsedWidth = 8;
const double _kPageViewIndicatorHeight = 3.5;
const double _kPageViewIndicatorBorderRadius = 2;
const double _kIndicatorSpacing = 2;

class PageViewIndicator extends StatelessWidget {
  final PageController controller;
  final int pageCount;

  final PageViewIndicatorBloc pageViewIndicatorBloc = PageViewIndicatorBloc();
  PageViewIndicator({Key? key, required this.controller, required this.pageCount}) : super(key: key) {
    controller.addListener(() {
      pageViewIndicatorBloc.onIndexChanged(controller.page?.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buildSliderIndicator().toList(),
    );
  }

  Iterable<Widget> buildSliderIndicator() sync* {
    for (int i = 0; i < pageCount; i++) {
      yield BlocBuilder(
          bloc: pageViewIndicatorBloc,
          builder: () {
            return sliderIndexExpanded(
                isExpanded: pageViewIndicatorBloc.state == i);
          });
    }
  }

  Widget sliderIndexExpanded({bool isExpanded = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: kExpandingAnimationDuration),
      width: isExpanded ? _kExpandedWidth : _kCollapsedWidth,
      height: _kPageViewIndicatorHeight,
      margin: const EdgeInsets.only(
          right: _kIndicatorSpacing, left: _kIndicatorSpacing),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kPageViewIndicatorBorderRadius),
          color:
              isExpanded ? AppColors.kGrey40Alpha80 : AppColors.kGrey40Alpha50),
    );
  }
}
