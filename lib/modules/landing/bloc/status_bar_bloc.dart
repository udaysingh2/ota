import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kStatusBarOffset = 198;
const double _kDynamicStatusBarOffset = 100;

class StatusBarBloc extends Bloc<StatusBarBlocModel> {
  @override
  StatusBarBlocModel initDefaultValue() {
    return StatusBarBlocModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicStatusBarOffset = _kDynamicStatusBarOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicStatusBarOffset ?? _kStatusBarOffset)) {
      if (state.statusBarBlocState != StatusBarBlocState.closing) {
        state.statusBarBlocState = StatusBarBlocState.closing;
        emit(state);
      }
    } else {
      if (state.statusBarBlocState != StatusBarBlocState.opened) {
        state.statusBarBlocState = StatusBarBlocState.opened;
        emit(state);
      }
    }
  }
}

class StatusBarBlocModel {
  StatusBarBlocState statusBarBlocState;
  double? dynamicStatusBarOffset;
  StatusBarBlocModel({this.statusBarBlocState = StatusBarBlocState.opened});
}

enum StatusBarBlocState { opened, closing, closed }
