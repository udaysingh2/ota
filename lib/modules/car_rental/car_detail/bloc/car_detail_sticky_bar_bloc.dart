import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kCardHeadOffset = 480;
const double _kDynamicCardHeadOffset = 360;

class CarDetailStickyBarBloc extends Bloc<CarDetailStickyBarModel> {
  @override
  CarDetailStickyBarModel initDefaultValue() {
    return CarDetailStickyBarModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicCardHeadOffset = _kDynamicCardHeadOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicCardHeadOffset ?? _kCardHeadOffset)) {
      if (state.cardHeadBlocState != CarDetailStickyBarState.nonSticky) {
        state.cardHeadBlocState = CarDetailStickyBarState.nonSticky;
        emit(state);
      }
    } else {
      if (state.cardHeadBlocState != CarDetailStickyBarState.sticky) {
        state.cardHeadBlocState = CarDetailStickyBarState.sticky;
        emit(state);
      }
    }
  }

  void setStateSticky() {
    if (state.cardHeadBlocState != CarDetailStickyBarState.sticky) {
      state.cardHeadBlocState = CarDetailStickyBarState.sticky;
      emit(state);
    }
  }
}

class CarDetailStickyBarModel {
  CarDetailStickyBarState cardHeadBlocState;
  double? dynamicCardHeadOffset;
  CarDetailStickyBarModel({
    this.cardHeadBlocState = CarDetailStickyBarState.sticky,
  });
}

enum CarDetailStickyBarState { sticky, nonSticky }
