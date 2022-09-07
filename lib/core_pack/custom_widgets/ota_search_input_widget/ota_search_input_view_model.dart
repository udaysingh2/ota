class OtaSearchInputModel {
  OtaSearchInputState tourSearchScreenState;
  OtaSearchInputModel({this.tourSearchScreenState = OtaSearchInputState.empty});
}

enum OtaSearchInputState { none, empty, notEmpty }
