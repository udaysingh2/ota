import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kCardHeadOffset = 480;
const double _kDynamicCardHeadOffset = 370;

class TourCardHeadBloc extends Bloc<TourCardHeadBlocModel> {
  @override
  TourCardHeadBlocModel initDefaultValue() {
    return TourCardHeadBlocModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicCardHeadOffset = _kDynamicCardHeadOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicCardHeadOffset ?? _kCardHeadOffset)) {
      if (state.cardHeadBlocState != TourCardHeadBlocState.nonSticky) {
        state.cardHeadBlocState = TourCardHeadBlocState.nonSticky;
        emit(state);
      }
    } else {
      if (state.cardHeadBlocState != TourCardHeadBlocState.sticky) {
        state.cardHeadBlocState = TourCardHeadBlocState.sticky;
        emit(state);
      }
    }
  }

  void setStateSticky() {
    if (state.cardHeadBlocState != TourCardHeadBlocState.sticky) {
      state.cardHeadBlocState = TourCardHeadBlocState.sticky;
      emit(state);
    }
  }
}

class TourCardHeadBlocModel {
  TourCardHeadBlocState cardHeadBlocState;
  double? dynamicCardHeadOffset;
  TourCardHeadBlocModel(
      {this.cardHeadBlocState = TourCardHeadBlocState.sticky});
}

enum TourCardHeadBlocState { sticky, nonSticky }
