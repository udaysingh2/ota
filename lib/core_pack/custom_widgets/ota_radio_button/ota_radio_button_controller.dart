import 'dart:core';

import 'package:ota/core_components/bloc/bloc.dart';

import 'ota_radio_button_model.dart';

class OtaRadioButtonController extends Bloc<OtaRadioButtonModel> {
  @override
  OtaRadioButtonModel initDefaultValue() {
    return OtaRadioButtonModel();
  }

  void setSelected() {
    emit(
        OtaRadioButtonModel(otaRadioButtonState: OtaRadioButtonState.selected));
  }

  void setUnSelected() {
    emit(OtaRadioButtonModel(
        otaRadioButtonState: OtaRadioButtonState.unselected));
  }

  bool isSelected() {
    return state.otaRadioButtonState == OtaRadioButtonState.selected;
  }

  OtaRadioButtonState getState() {
    return state.otaRadioButtonState;
  }
}
