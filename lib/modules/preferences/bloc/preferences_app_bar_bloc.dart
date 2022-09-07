import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kStatusBarOffset = 25;
const double _kDynamicStatusBarOffset = 5;

class PreferencesAppBarBloc extends Bloc<PreferencesAppBarBlocModel> {
  @override
  PreferencesAppBarBlocModel initDefaultValue() {
    return PreferencesAppBarBlocModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicStatusBarOffset = _kDynamicStatusBarOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicStatusBarOffset ?? _kStatusBarOffset)) {
      if (state.preferencesAppBarBlocState !=
          PreferencesAppBarBlocState.closing) {
        state.preferencesAppBarBlocState = PreferencesAppBarBlocState.closing;
        emit(state);
      }
    } else {
      if (state.preferencesAppBarBlocState !=
          PreferencesAppBarBlocState.opened) {
        state.preferencesAppBarBlocState = PreferencesAppBarBlocState.opened;
        emit(state);
      }
    }
  }

  bool isOpened() =>
      state.preferencesAppBarBlocState == PreferencesAppBarBlocState.opened;

  bool isClosed() =>
      state.preferencesAppBarBlocState == PreferencesAppBarBlocState.closed;
}

class PreferencesAppBarBlocModel {
  PreferencesAppBarBlocState preferencesAppBarBlocState;
  double? dynamicStatusBarOffset;
  PreferencesAppBarBlocModel(
      {this.preferencesAppBarBlocState = PreferencesAppBarBlocState.opened});
}

enum PreferencesAppBarBlocState { opened, closing, closed }
