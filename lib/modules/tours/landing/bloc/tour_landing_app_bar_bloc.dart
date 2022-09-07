import 'package:flutter/cupertino.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kStatusBarOffset = 50;
const double _kDynamicStatusBarOffset = 30;

class TourLandingAppBarBloc extends Bloc<TourLandingAppBarBlocModel> {
  @override
  TourLandingAppBarBlocModel initDefaultValue() {
    return TourLandingAppBarBlocModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicStatusBarOffset = _kDynamicStatusBarOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicStatusBarOffset ?? _kStatusBarOffset)) {
      if (state.tourLandingAppBarBlocState !=
          TourLandingAppBarBlocState.closing) {
        state.tourLandingAppBarBlocState = TourLandingAppBarBlocState.closing;
        emit(state);
      }
    } else {
      if (state.tourLandingAppBarBlocState !=
          TourLandingAppBarBlocState.opened) {
        state.tourLandingAppBarBlocState = TourLandingAppBarBlocState.opened;
        emit(state);
      }
    }
  }

  bool get isOpened =>
      state.tourLandingAppBarBlocState == TourLandingAppBarBlocState.opened;

  bool get isClosing =>
      state.tourLandingAppBarBlocState == TourLandingAppBarBlocState.closing;
}

class TourLandingAppBarBlocModel {
  TourLandingAppBarBlocState tourLandingAppBarBlocState;
  double? dynamicStatusBarOffset;
  TourLandingAppBarBlocModel(
      {this.tourLandingAppBarBlocState = TourLandingAppBarBlocState.opened});
}

enum TourLandingAppBarBlocState { opened, closing, closed }
