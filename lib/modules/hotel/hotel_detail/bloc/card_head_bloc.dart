import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';

const double _kCardHeadOffset = 480;
const double _kDynamicCardHeadOffset = 360;

class CardHeadBloc extends Bloc<CardHeadBlocModel> {
  @override
  CardHeadBlocModel initDefaultValue() {
    return CardHeadBlocModel();
  }

  void setDynamicCardHeadOffset(double value) {
    state.dynamicCardHeadOffset = _kDynamicCardHeadOffset + value;
  }

  void setStatusOnScroll(ScrollController scrollController) {
    if (scrollController.offset >=
        (state.dynamicCardHeadOffset ?? _kCardHeadOffset)) {
      if (state.cardHeadBlocState != CardHeadBlocState.nonSticky) {
        state.cardHeadBlocState = CardHeadBlocState.nonSticky;
        emit(state);
      }
    } else {
      if (state.cardHeadBlocState != CardHeadBlocState.sticky) {
        state.cardHeadBlocState = CardHeadBlocState.sticky;
        emit(state);
      }
    }
  }

  void setStateSticky() {
    if (state.cardHeadBlocState != CardHeadBlocState.sticky) {
      state.cardHeadBlocState = CardHeadBlocState.sticky;
      emit(state);
    }
  }
}

class CardHeadBlocModel {
  CardHeadBlocState cardHeadBlocState;
  double? dynamicCardHeadOffset;
  CardHeadBlocModel({this.cardHeadBlocState = CardHeadBlocState.sticky});
}

enum CardHeadBlocState { sticky, nonSticky }
