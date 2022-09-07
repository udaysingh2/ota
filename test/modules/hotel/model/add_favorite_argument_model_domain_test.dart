import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  HotelDetailModel model = HotelDetailModel(
    id: "ABC123344",
    address: "Bangkok",
    checkInDate: "",
    checkOutDate: "",
    coverImageUrl: "",
    shortAddress: "Thailland",
    name: "Shangig Hotel",
    freeFoodPromotions: [],
  );
  test("Add Fav Argumernt Model", () {
    AddFavoriteArgumentModelDomain addFavoriteModelDomain =
        AddFavoriteArgumentModelDomain.mapArgumentModel(
            getHotelDetailArgumentMock(), model);
    expect(addFavoriteModelDomain.hotelName, "Shangig Hotel");
  });
}
