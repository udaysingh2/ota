class OtaRadioButtonModel {
  OtaRadioButtonState otaRadioButtonState;
  OtaRadioButtonModel(
      {this.otaRadioButtonState = OtaRadioButtonState.unselected});
}

enum OtaRadioButtonState {
  selected,
  unselected,
}
