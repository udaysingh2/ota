import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_all_view_model.dart';

class FavouritesAllListViewModel {
  List<FavouritesAllViewModel> favouritesList;
  OtaFavouritesPageState favouritesScreenState;

  FavouritesAllListViewModel({
    required this.favouritesList,
    this.favouritesScreenState = OtaFavouritesPageState.none,
  });
}
