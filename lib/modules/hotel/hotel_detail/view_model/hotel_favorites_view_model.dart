import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';

class HotelFavoritesViewModel {
  HotelDetailHeartButtonType heartButtonType;
  UnFavoriteHotelState unFavoriteHotelState;
  AddFavoriteHotelState addFavoriteHotelState;
  HotelFavoritesViewModel({
    this.heartButtonType = HotelDetailHeartButtonType.unselected,
    this.unFavoriteHotelState = UnFavoriteHotelState.none,
    this.addFavoriteHotelState = AddFavoriteHotelState.none,
  });
}

enum UnFavoriteHotelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
enum AddFavoriteHotelState {
  none,
  loading,
  success,
  // failureUnautheticated,
  failureMaxLimit,
  // failureAlreadyAdded,
  failure,
  internetFailure,
}
