import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/view_model/tour_card_view_model.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';

class TourVerticalCardViewModel {
  String? id;
  String? name;
  String? locationName;
  String? cityId;
  String? cityName;
  String? countryId;
  List<TourVerticalCardPromotions>? capsulePromotion;
  int? rating;
  List<dynamic>? infoPromotion;
  String? imageUrl;
  String? styleName;
  double? startPrice;
  String? promotionTextLineOne;
  String? promotionTextLineTwo;

  TourVerticalCardViewModel({
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

  factory TourVerticalCardViewModel.fromCard(TourCard card) {
    return TourVerticalCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      capsulePromotion:
          PlaylistHelper.getTourCardPromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion: card.infoPromotion,
      imageUrl: card.imageUrl,
      styleName: card.styleName,
      startPrice: card.startPrice,
      promotionTextLineOne: card.promotionTextLine1,
      promotionTextLineTwo: card.promotionTextLine2,
    );
  }

  factory TourVerticalCardViewModel.fromTourCardViewModel(
      TourCardViewModel card) {
    if (card.name != null && card.name!.isEmpty) {
      return TourVerticalCardViewModel();
    }
    return TourVerticalCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      capsulePromotion:
          PlaylistHelper.getCardPromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion: card.infoPromotion,
      imageUrl: card.imageUrl,
      styleName: card.styleName,
      startPrice: card.startPrice,
      promotionTextLineOne: card.promotionTextLineOne,
      promotionTextLineTwo: card.promotionTextLineTwo,
    );
  }
}

class TourVerticalCardPromotions {
  String? name;
  String? code;
  TourVerticalCardPromotions({this.name, this.code});
}
