import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';

class CarRentalViewModel {
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
  List<CarCardPromotions>? capsulePromotion;
  int? rating;
  List<dynamic>? infoPromotion;
  String? imageUrl;
  String? styleName;
  double? startPrice;
  String? promotionTextLineOne;
  String? promotionTextLineTwo;

  CarRentalViewModel({
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

  factory CarRentalViewModel.fromCard(CarCard card) {
    return CarRentalViewModel(
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
          LandingPageHelper.getCarCardPromotionList(card.capsulePromotion),
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

class CarCardPromotions {
  String? name;
  String? code;
  CarCardPromotions({this.name, this.code});
}
