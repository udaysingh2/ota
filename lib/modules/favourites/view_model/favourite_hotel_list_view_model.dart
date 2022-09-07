import 'package:ota/modules/favourites/view_model/favourite_hotel_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';

class FavouritesListViewModel {
  List<FavouritesHotelViewModel> favouritesList;
  OtaFavouritesPageState favouritesScreenState;
  OtaFavouritesPageState unFavouritesState;

  FavouritesListViewModel({
    required this.favouritesList,
    this.favouritesScreenState = OtaFavouritesPageState.none,
    this.unFavouritesState = OtaFavouritesPageState.none,
  });
}
