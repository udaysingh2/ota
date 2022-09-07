class TourSearchScreenModel {
  TourSearchScreenState tourSearchScreenState;
  TourSearchScreenModel(
      {this.tourSearchScreenState = TourSearchScreenState.none});
}

enum TourSearchScreenState { none, recommendations, suggestions }
