import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/favourite_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_favorites_view_model.dart';

void main() {
  test("Favorite helper", () {
    AddFavoriteHotelState addFavoriteHotelState =
        FavoriteHelper.getAddFavoriteState("Limit exceeded");
    expect(addFavoriteHotelState, AddFavoriteHotelState.failureMaxLimit);
    addFavoriteHotelState = FavoriteHelper.getAddFavoriteState("Bad Request");
    expect(addFavoriteHotelState, AddFavoriteHotelState.failure);
  });
}
