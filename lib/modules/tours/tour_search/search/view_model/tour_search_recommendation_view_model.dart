class TourSearchRecommendationViewModel {
  TourSearchRecommendationState recommendationState;

  TourSearchRecommendationViewModel(
      {this.recommendationState = TourSearchRecommendationState.none});
}

enum TourSearchRecommendationState { none, loading, failure, success }
