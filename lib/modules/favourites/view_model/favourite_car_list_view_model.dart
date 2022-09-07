import 'package:ota/modules/favourites/view_model/favourite_car_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';

class FavouritesCarListViewModel {
  List<FavouritesCarViewModel> favouritesList;
  OtaFavouritesPageState favouritesScreenState;
  bool isInternetPopupShown = false;

  FavouritesCarListViewModel({
    required this.favouritesList,
    this.favouritesScreenState = OtaFavouritesPageState.none,
  });
}
