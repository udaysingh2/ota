import 'favourite_tour_view_model.dart';

class FavouritesTourListViewModel {
  List<FavouritesTourViewModel> favouritesList;
  OtaFavouritesPageState favouritesScreenState;

  FavouritesTourListViewModel({
    required this.favouritesList,
    this.favouritesScreenState = OtaFavouritesPageState.none,
  });
}

enum OtaFavouritesPageState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  emptyData,
  emptyDataPullDownLoading,
  errorCasePullDownLoading,
  unFavoriteLoading,
  unFavoriteFailure,
  unFavoriteSuccess,
  unFavoriteInternetFailure,
  internetFailure,
  internetFailureRefresh,
  emptyInternetFailureRefresh,
}
