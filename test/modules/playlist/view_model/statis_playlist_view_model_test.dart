import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/playlist/view_model/statis_playlist_view_model.dart';

void main() {
  ListElement listElement = ListElement(
    hotelName: "Hotel Name",
    image: "Image",
    rating: 4.0,
    hotelId: 'Hotel Id',
    address: Address(
      cityId: "City Id",
      countryId: "Country Id",
      cityName: "City",
      countryName: "",
      locationId: "",
      locationName: "",
      address1: "",
    ),
    review: Review(score: 4, numReview: 4, description: "Description"),
    adminPromotion: AdminPromotion(
        promotionText2: "Promotion Text 2",
        promotionText1: "Promotion Text 1",
        adminPromotionLine2: "",
        adminPromotionLine1: ""),
    promotion: [Promotion(promotionText: "")],
  );

  test("Static Playlist View Model test... ", () async {
    final data = StaticPlaylistCardViewModel.fromListElement(listElement);

    expect(data.score, '4');
    expect(data.reviewText, '4');
    expect(data.rating?.isNotEmpty, true);
    expect(data.reviewTitle, "Description");
    expect(data.hotelId, "Hotel Id");
    expect(data.offerValue, "");
    expect(data.discountValue, "");
    expect(data.hotelName, "Hotel Name");
    expect(data.addressText, "City");
    expect(data.promotionText1, "Promotion Text 1");
    expect(data.promotionText2, "Promotion Text 2");
    expect(data.cityId, "City Id");
    expect(data.countryId, "Country Id");
  });
}
