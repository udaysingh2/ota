import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/playlist/helpers/static_playlist_helper.dart';

void main() {
  const double kDefaultStarRating = 2.0;
  const double kMaxStarRating = 5;

  List<ListElement> listElement = [
    ListElement(
      hotelId: "123",
      address: Address(
          countryId: "123",
          cityId: "123",
          address1: "aaaa",
          cityName: "Bangkok",
          countryName: "Taiwan",
          locationId: "asf",
          locationName: "Bangkok"),
      hotelName: "Hotel",
      image: "",
      promotion: [
        Promotion(
          promotionText: "asdf",
        ),
        Promotion(
          promotionText: "lkjh",
        )
      ],
      rating: 1.0,
      review: Review(description: "", numReview: 4, score: 4),
      adminPromotion: AdminPromotion(
          adminPromotionLine1: "",
          adminPromotionLine2: "",
          promotionText1: "",
          promotionText2: ""),
    )
  ];

  test("Static playlist helper test...", () {
    expect(
        StaticPlaylistHelper.getPlaylistCardViewModelList(listElement) != null,
        true);
    StaticPlaylistHelper.updateStarRating(kDefaultStarRating);
    expect(StaticPlaylistHelper.updateStarRating(kDefaultStarRating), "2.0");
    expect(StaticPlaylistHelper.updateStarRating(kMaxStarRating), "5");
  });
}
