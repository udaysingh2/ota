class TourSaveSearchHistoryViewModel {
  TourSaveSearchHistoryViewModelState? tourSaveSearchHistoryViewModelState;

  TourSaveSearchHistoryViewModel(
      {this.tourSaveSearchHistoryViewModelState =
          TourSaveSearchHistoryViewModelState.none});
}

enum TourSaveSearchHistoryViewModelState {
  none,
  loading,
  success,
  failure,
}
