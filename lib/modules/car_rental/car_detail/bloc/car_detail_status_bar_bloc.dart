import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kStatusBarOffset = 350;
const double _kDynamicStatusBarOffset = 230;

class CarDetailStatusBarBloc extends Bloc<CarDetailStatusBarModel> {
  @override
  CarDetailStatusBarModel initDefaultValue() {
    return CarDetailStatusBarModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicStatusBarOffset = _kDynamicStatusBarOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicStatusBarOffset ?? _kStatusBarOffset)) {
      if (state.statusBarBlocState != CarDetailStatusBarState.closing) {
        state.statusBarBlocState = CarDetailStatusBarState.closing;
        emit(state);
      }
    } else {
      if (state.statusBarBlocState != CarDetailStatusBarState.opened) {
        state.statusBarBlocState = CarDetailStatusBarState.opened;
        emit(state);
      }
    }
  }

  void setStatusOpened() {
    if (state.statusBarBlocState != CarDetailStatusBarState.opened) {
      state.statusBarBlocState = CarDetailStatusBarState.opened;
      emit(state);
    }
  }

  void setEnable() {
    emit(CarDetailStatusBarModel(shareButtonState: ShareButtonState.enable));
  }

  void setDisabled() {
    emit(CarDetailStatusBarModel(shareButtonState: ShareButtonState.disable));
  }
}

class CarDetailStatusBarModel {
  CarDetailStatusBarState statusBarBlocState;
  double? dynamicStatusBarOffset;
  ShareButtonState shareButtonState;
  CarDetailStatusBarModel(
      {this.statusBarBlocState = CarDetailStatusBarState.opened,
      this.shareButtonState = ShareButtonState.disable});
}

enum CarDetailStatusBarState { opened, closing, closed }
enum ShareButtonState { enable, disable }
