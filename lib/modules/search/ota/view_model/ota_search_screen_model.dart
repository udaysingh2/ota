class OtaSearchScreenModel {
  OtaSearchScreenState otaSearchScreenState;
  OtaSearchScreenModel({this.otaSearchScreenState = OtaSearchScreenState.none});
}

enum OtaSearchScreenState { none, recommendations, suggestions, results }
