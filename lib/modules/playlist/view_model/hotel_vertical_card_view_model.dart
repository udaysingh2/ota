import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/view_model/hotel_card_view_model.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';

class HotelVerticalCardViewModel {
  String? id;
  String? name;
  String? locationName;
  String? cityId;
  String? cityName;
  String? countryId;
  List<HotelVerticalCardPromotions>? capsulePromotion;
  int? rating;
  List<String>? infoPromotion;
  String? imageUrl;
  double? startPrice;
  String? promotionTextLine1;
  String? promotionTextLine2;

  HotelVerticalCardViewModel({
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

  factory HotelVerticalCardViewModel.fromCard(HotelCard card) {
    return HotelVerticalCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      capsulePromotion:
          PlaylistHelper.getHotelCapsulePromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion:
          PlaylistHelper.getHotelInfoPromotionList(card.infoPromotion),
      imageUrl: card.imageUrl,
      startPrice: card.startPrice,
      promotionTextLine1: card.promotionTextLine1,
      promotionTextLine2: card.promotionTextLine2,
    );
  }

  factory HotelVerticalCardViewModel.fromHotelCardViewModel(
      HotelCardViewModel card) {
    if (card.name != null && card.name!.isEmpty) {
      return HotelVerticalCardViewModel();
    }
    return HotelVerticalCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      capsulePromotion:
          PlaylistHelper.getHotelCardPromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion: card.infoPromotion,
      imageUrl: card.imageUrl,
      startPrice: card.startPrice,
      promotionTextLine1: card.promotionTextLine1,
      promotionTextLine2: card.promotionTextLine2,
    );
  }
}

class HotelVerticalCardPromotions {
  String? name;
  String? code;
  HotelVerticalCardPromotions({this.name, this.code});
}
