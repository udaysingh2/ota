class HeartButtonModel {
  HeartButtonState heartButtonState;
  HeartButtonModel({this.heartButtonState = HeartButtonState.disabled});
}

enum HeartButtonState {
  disabled,
  selected,
  unselected,
}
