import 'dart:core';

import 'package:ota/core_components/bloc/bloc.dart';

import 'heart_button_car_rental_model.dart';

class HeartButtonCarRentalController extends Bloc<HeartButtonCarRentalModel> {
  @override
  HeartButtonCarRentalModel initDefaultValue() {
    return HeartButtonCarRentalModel();
  }

  void setSelected() {
    emit(HeartButtonCarRentalModel(
        heartButtonCarRentalState: HeartButtonCarRentalState.selected));
  }

  void setDisabled() {
    emit(HeartButtonCarRentalModel(
        heartButtonCarRentalState: HeartButtonCarRentalState.disabled));
  }

  void setUnselected() {
    emit(HeartButtonCarRentalModel(
        heartButtonCarRentalState: HeartButtonCarRentalState.unselected));
  }

  void toggle() {
    if (state.heartButtonCarRentalState == HeartButtonCarRentalState.selected) {
      emit(HeartButtonCarRentalModel(
          heartButtonCarRentalState: HeartButtonCarRentalState.unselected));
    } else {
      emit(HeartButtonCarRentalModel(
          heartButtonCarRentalState: HeartButtonCarRentalState.selected));
    }
  }

  HeartButtonCarRentalState getState() {
    return state.heartButtonCarRentalState;
  }
}
