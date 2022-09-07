import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/view_model/car_card_view_model.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';

class CarVerticalCardViewModel {
  String? id;
  String? name;
  String? locationName;
  String? cityId;
  String? cityName;
  String? countryId;
  String? countryName;
  String? locationId;
  String? pickupLocationId;
  String? returnLocationId;
  String? address;
  String? address1;
  String? craftType;
  List<CarVerticalCardPromotions>? capsulePromotion;
  int? rating;
  List<dynamic>? infoPromotion;
  String? imageUrl;
  String? styleName;
  double? startPrice;
  String? promotionTextLineOne;
  String? promotionTextLineTwo;

  CarVerticalCardViewModel({
    this.id,
    this.name,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.pickupLocationId,
    this.returnLocationId,
    this.craftType,
    this.capsulePromotion,
    this.rating,
    this.infoPromotion,
    this.imageUrl,
    this.styleName,
    this.startPrice,
    this.promotionTextLineOne,
    this.promotionTextLineTwo,
  });

  factory CarVerticalCardViewModel.fromCard(CarCard card) {
    return CarVerticalCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      pickupLocationId: card.pickupLocationId,
      returnLocationId: card.returnLocationId,
      craftType: card.craftType,
      capsulePromotion:
          PlaylistHelper.getCarCardPromotionList(card.capsulePromotion),
      rating: card.rating,
      infoPromotion: card.infoPromotion,
      imageUrl: card.imageUrl,
      styleName: card.styleName,
      startPrice: card.startPrice,
      promotionTextLineOne: card.promotionTextLine1,
      promotionTextLineTwo: card.promotionTextLine2,
    );
  }

  factory CarVerticalCardViewModel.fromCarCardViewModel(
      CarRentalViewModel card) {
    if (card.name != null && card.name!.isEmpty) {
      return CarVerticalCardViewModel();
    }
    return CarVerticalCardViewModel(
      id: card.id,
      name: card.name,
      locationName: card.locationName,
      cityId: card.cityId,
      cityName: card.cityName,
      countryId: card.countryId,
      pickupLocationId: card.pickupLocationId,
      returnLocationId: card.returnLocationId,
      craftType: card.craftType,
      capsulePromotion:
          PlaylistHelper.getCardCarPromotionList(card.capsulePromotion),
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

class CarVerticalCardPromotions {
  String? name;
  String? code;
  CarVerticalCardPromotions({this.name, this.code});
}
