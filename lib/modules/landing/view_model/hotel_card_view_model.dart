import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';

class HotelCardViewModel {
  String? id;
  String? name;
  String? locationName;
  String? cityId;
  String? cityName;
  String? countryId;
  List<HotelCardPromotions>? capsulePromotion;
  int? rating;
  List<String>? infoPromotion;
  String? imageUrl;
  double? startPrice;
  String? promotionTextLine1;
  String? promotionTextLine2;

  HotelCardViewModel({
    this.id,
    this.name,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.capsulePromotion,
    this.rating,
    this.infoPromotion,
    this.imageUrl,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
  });

  factory HotelCardViewModel.fromCard(HotelCard card) {
    return HotelCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      capsulePromotion:
          LandingPageHelper.getHotelCapsulePromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion:
          LandingPageHelper.getHotelInfoPromotionList(card.infoPromotion),
      imageUrl: card.imageUrl,
      startPrice: card.startPrice,
      promotionTextLine1: card.promotionTextLine1,
      promotionTextLine2: card.promotionTextLine2,
    );
  }
}

class HotelCardPromotions {
  String? name;
  String? code;
  HotelCardPromotions({this.name, this.code});
}
