import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';
import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';

void main() {
  const int kDefaultStarRating = 2;
  const int kMaxStarRating = 5;

  List<CapsulePromotion> capsulePromotion = [
    CapsulePromotion(name: "", code: ""),
  ];
  List<Infopromotion> infoPromotion = [
    Infopromotion(promotionText: ""),
  ];
  List<CardList> cardList = [
    CardList(
      locationName: "Bangkok",
      locationId: "",
      countryName: "",
      cityName: "",
      cityId: "",
      countryId: "",
      review: Review(description: "", numReview: 4, score: 4),
      rating: 1,
      address: "",
      imageUrl: "",
      capsulePromotion: [
        CapsulePromotion(name: "", code: ""),
        CapsulePromotion(name: "", code: ""),
      ],
      id: "",
      infopromotion: [
        Infopromotion(promotionText: ""),
      ],
      name: "",
      productType: "",
      promotionTextLine1: "",
      promotionTextLine2: "",
      startPrice: 10,
      styleName: "",
    )
  ];

  List<Promotions> promotions = [Promotions(name: "", code: "")];
  test("Playlist helper test...", () {
    expect(PlaylistHelper.getPlaylistCardViewModelList(cardList) != null, true);
    PlaylistHelper.updateStarRating(kDefaultStarRating);
    expect(PlaylistHelper.updateStarRating(kDefaultStarRating), "2");
    expect(PlaylistHelper.updateStarRating(kMaxStarRating), "5");
    PlaylistHelper.getCapsulePromotionList(capsulePromotion);
    PlaylistHelper.getInfoPromotionList(infoPromotion);
    PlaylistHelper.getAmenitiesList(promotions, ["infoPromotion"]);
  });
}
