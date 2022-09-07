import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';

class TourCardViewModel {
  String? id;
  String? name;
  String? locationName;
  String? cityId;
  String? cityName;
  String? countryId;
  List<TourCardPromotions>? capsulePromotion;
  int? rating;
  List<dynamic>? infoPromotion;
  String? imageUrl;
  String? styleName;
  double? startPrice;
  String? promotionTextLineOne;
  String? promotionTextLineTwo;

  TourCardViewModel({
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
    this.styleName,
    this.startPrice,
    this.promotionTextLineOne,
    this.promotionTextLineTwo,
  });

  factory TourCardViewModel.fromCard(TourCard card) {
    return TourCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      capsulePromotion:
          LandingPageHelper.getTourCardPromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion: card.infoPromotion,
      imageUrl: card.imageUrl,
      styleName: card.styleName,
      startPrice: card.startPrice,
      promotionTextLineOne: card.promotionTextLine1,
      promotionTextLineTwo: card.promotionTextLine2,
    );
  }
}

class TourCardPromotions {
  String? name;
  String? code;
  TourCardPromotions({this.name, this.code});
}
