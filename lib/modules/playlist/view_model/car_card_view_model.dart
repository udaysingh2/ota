class CarCardViewModel {
  String? id;
  String? name;
  String? locationName;
  String? cityId;
  String? cityName;
  String? countryId;
  List<CarCardPromotions>? capsulePromotion;
  int? rating;
  List<dynamic>? infoPromotion;
  String? imageUrl;
  String? styleName;
  double? startPrice;
  String? promotionTextLineOne;
  String? promotionTextLineTwo;
  String? craftType;
  String? pickupLocationId;
  String? returnLocationId;

  CarCardViewModel({
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
    this.craftType,
    this.pickupLocationId,
    this.returnLocationId,
  });
}

class CarCardPromotions {
  String? name;
  String? code;
  CarCardPromotions({this.name, this.code});
}
