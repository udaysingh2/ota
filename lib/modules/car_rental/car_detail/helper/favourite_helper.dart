import 'package:ota/modules/car_rental/car_detail/view_model/car_rental_favorites_view_model.dart';

const kLimitExceed = "Limit exceeded";
const kLimitExceededThai = "ไม่มีข้อมูล";

class FavoriteHelper {
  static AddFavoriteCarRentalState getAddFavoriteState(String header) {
    if (header == kLimitExceed || header == kLimitExceededThai) {
      return AddFavoriteCarRentalState.failureMaxLimit;
    } else {
      return AddFavoriteCarRentalState.failure;
    }
  }
}
