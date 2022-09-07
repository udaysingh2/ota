import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_view_model.dart';

class CarRentalFavoritesViewModel {
  CarRentalDetailHeartButtonType heartButtonType;
  UnFavoriteCarRentalState unFavoriteCarRentalState;
  AddFavoriteCarRentalState addFavoriteCarRentalState;
  CarRentalFavoritesViewModel({
    this.heartButtonType = CarRentalDetailHeartButtonType.disabled,
    this.unFavoriteCarRentalState = UnFavoriteCarRentalState.none,
    this.addFavoriteCarRentalState = AddFavoriteCarRentalState.none,
  });
}

enum UnFavoriteCarRentalState {
  none,
  loading,
  success,
  failure,
  failureNetwork,
}
enum AddFavoriteCarRentalState {
  none,
  loading,
  success,
  failureMaxLimit,
  failure,
  failureNetwork,
}
