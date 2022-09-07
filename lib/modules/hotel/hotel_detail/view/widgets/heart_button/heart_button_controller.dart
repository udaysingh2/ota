import 'dart:core';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_model.dart';

class HeartButtonController extends Bloc<HeartButtonModel> {
  @override
  HeartButtonModel initDefaultValue() {
    return HeartButtonModel();
  }

  void setSelected() {
    emit(HeartButtonModel(heartButtonState: HeartButtonState.selected));
  }

  void setDisabled() {
    emit(HeartButtonModel(heartButtonState: HeartButtonState.disabled));
  }

  void setUnselected() {
    emit(HeartButtonModel(heartButtonState: HeartButtonState.unselected));
  }

  void toggle() {
    if (state.heartButtonState == HeartButtonState.selected) {
      emit(HeartButtonModel(heartButtonState: HeartButtonState.unselected));
    } else {
      emit(HeartButtonModel(heartButtonState: HeartButtonState.selected));
    }
  }

  HeartButtonState getState() {
    return state.heartButtonState;
  }
}
