class OtaFavoritesViewModel {
  FavoritePageState pageState;
  bool isFavourite;
  OtaFavoritesViewModel({
    this.pageState = FavoritePageState.none,
    this.isFavourite = false,
  });
}

enum FavoritePageState {
  none,
  loading,
  success,
  failure,
  addFavouriteFailure,
  unFavoriteFailure,
  failureMaxLimit,
  addfavouriteInternetFailure,
  unfavouriteInternetFailure,
}
