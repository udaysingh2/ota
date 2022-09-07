class CarSearchScreenModel {
  CarSearchScreenState carSearchScreenState;
  CarSearchScreenModel({this.carSearchScreenState = CarSearchScreenState.none});
}

enum CarSearchScreenState { none, suggestions, recommendations }
