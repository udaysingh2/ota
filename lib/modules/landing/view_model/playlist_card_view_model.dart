import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart'
    as ota_model;

import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';

class PlaylistCardViewModel {
  String headerText;
  String ratingText;
  String score;
  String addressText;
  String ratingTitle;
  String reviewText;
  String offerPercent;
  String discount;
  String imageUrl;
  String cityId;
  String hotelId;
  String countryId;
  String adminPromotionLine1;
  String adminPromotionLine2;
  String locationName;
  List<Promotions> capsulePromotion;
  List<String> infoPromotion;

  PlaylistCardViewModel({
    this.headerText = "",
    this.ratingText = "1",
    this.score = "",
    this.addressText = "",
    this.ratingTitle = "",
    this.reviewText = "",
    this.offerPercent = "",
    this.discount = "",
    this.imageUrl = "",
    this.cityId = "",
    this.countryId = "",
    this.hotelId = "",
    this.adminPromotionLine1 = "",
    this.adminPromotionLine2 = "",
    this.locationName = "",
    this.capsulePromotion = const [],
    this.infoPromotion = const [],
  });

  factory PlaylistCardViewModel.fromOtaLandingList(ota_model.CardList list) {
    return PlaylistCardViewModel(
      headerText: list.name ?? '',
      addressText: list.address ?? '',
      cityId: list.cityId ?? '',
      hotelId: list.id ?? '',
      countryId: list.countryId ?? '',
      imageUrl: list.imageUrl ?? '',
      ratingText: PlaylistHelper.updateStarRating((list.rating ?? 0).toInt()),
      score:
          list.review?.score == null ? '' : "${list.review?.score?.toDouble()}",
      ratingTitle: list.review?.description ?? '',
      reviewText:
          list.review?.numReview == null ? '' : "${list.review?.numReview}",
      adminPromotionLine1: list.promotionTextLine1 ?? '',
      adminPromotionLine2: list.promotionTextLine2 ?? '',
      locationName: list.locationName ?? '',
      capsulePromotion: LandingPageHelper.getCapsulePromotionList(
          list.capsulePromotion ?? []),
          infoPromotion: LandingPageHelper.getInfoPromotionList(
          list.infopromotion ?? []),
    );
  }
}

class Promotions {
  String? name;
  String? code;
  Promotions({this.name, this.code});
}
