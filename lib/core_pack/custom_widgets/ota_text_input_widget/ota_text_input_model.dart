class OtaTextInputModel {
  OtaTextInputState otaTextInputState;
  OtaTextInputModel({this.otaTextInputState = OtaTextInputState.valid});
}

enum OtaTextInputState {
  valid,
  error,
  none,
}
