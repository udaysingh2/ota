import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kStatusBarOffset = 230;
const double _kDynamicStatusBarOffset = 230;

class InsuranceStatusBarBloc extends Bloc<InsuranceStatusBarBlocModel> {
  @override
  InsuranceStatusBarBlocModel initDefaultValue() {
    return InsuranceStatusBarBlocModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicStatusBarOffset = _kDynamicStatusBarOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicStatusBarOffset ?? _kStatusBarOffset)) {
      if (state.statusBarBlocState != InsuranceStatusBarBlocState.closing) {
        state.statusBarBlocState = InsuranceStatusBarBlocState.closing;
        emit(state);
      }
    } else {
      if (state.statusBarBlocState != InsuranceStatusBarBlocState.opened) {
        state.statusBarBlocState = InsuranceStatusBarBlocState.opened;
        emit(state);
      }
    }
  }

  void setStatusOpened() {
    if (state.statusBarBlocState != InsuranceStatusBarBlocState.opened) {
      state.statusBarBlocState = InsuranceStatusBarBlocState.opened;
      emit(state);
    }
  }
}

class InsuranceStatusBarBlocModel {
  InsuranceStatusBarBlocState statusBarBlocState;
  double? dynamicStatusBarOffset;
  InsuranceStatusBarBlocModel(
      {this.statusBarBlocState = InsuranceStatusBarBlocState.opened});
}

enum InsuranceStatusBarBlocState { opened, closing, closed }
