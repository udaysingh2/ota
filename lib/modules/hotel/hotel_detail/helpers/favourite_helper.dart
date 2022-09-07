import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_favorites_view_model.dart';

class FavoriteHelper {
  static AddFavoriteHotelState getAddFavoriteState(String header) {
    switch (header) {
      case "Limit exceeded":
        return AddFavoriteHotelState.failureMaxLimit;
      default:
        return AddFavoriteHotelState.failure;
    }
  }
}
