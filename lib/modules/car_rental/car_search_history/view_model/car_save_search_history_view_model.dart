class CarSaveSearchHistoryViewModel {
  CarSaveSearchHistoryViewModelState? carSaveSearchHistoryViewModelState;

  CarSaveSearchHistoryViewModel(
      {this.carSaveSearchHistoryViewModelState =
          CarSaveSearchHistoryViewModelState.none});
}

enum CarSaveSearchHistoryViewModelState {
  none,
  loading,
  success,
  failure,
}
