import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/helpers/car_rental_vertical_helper.dart';

class CarVerticalArgumentViewModel {
  CarRental? carModel;
  String? locationName;
  String? locationId;
  String? id;
  String? name;
  String? craftType;
  List<CarVerticalCardPromotionsData>? capsulePromotion;
  String? imageUrl;
  String? styleName;
  String? promotionTextLineOne;
  String? promotionTextLineTwo;

  CarVerticalArgumentViewModel({
    this.carModel,
    this.locationName,
    this.id,
    this.name,
    this.craftType,
    this.capsulePromotion,
    this.imageUrl,
    this.styleName,
    this.promotionTextLineOne,
    this.promotionTextLineTwo,
  });

  factory CarVerticalArgumentViewModel.fromCard(
      CarModelList card, Counter? pickupCounter) {
    return CarVerticalArgumentViewModel(
      id: pickupCounter?.locationId ?? '',
      name: (card.brandName ?? '') + (card.modelName ?? ''),
      capsulePromotion: CarRentalVerticalHelper.getCapsulePromotionList(
          card.capsulePromotion ?? []),
      imageUrl: card.images?.thumb ?? '',
      promotionTextLineOne:
          card.overlayPromotion?.adminPromotionLine1 ?? '',
      promotionTextLineTwo:
          card.overlayPromotion?.adminPromotionLine2 ?? '',
      styleName: card.carInfo?.carTypeName,
    );
  }

  // factory CarVerticalArgumentViewModel.fromCarCardViewModel(
  //     CarRentalViewModel card) {
  //   if (card.name != null && card.name!.isEmpty) {
  //     return CarVerticalCardViewModel();
  //   }
  //   return CarVerticalArgumentViewModel(
  //     id: card.id,
  //     name: card.name,
  //     locationName: card.locationName,
  //     cityId: card.cityId,
  //     cityName: card.cityName,
  //     countryId: card.countryId,
  //     pickupLocationId: card.pickupLocationId,
  //     returnLocationId: card.returnLocationId,
  //     craftType: card.craftType,
  //     capsulePromotion:
  //     PlaylistHelper.getCardPromotionList(card.capsulePromotion),
  //     rating: card.rating,
  //     infoPromotion: card.infoPromotion,
  //     imageUrl: card.imageUrl,
  //     styleName: card.styleName,
  //     startPrice: card.startPrice,
  //     promotionTextLineOne: card.promotionTextLineOne,
  //     promotionTextLineTwo: card.promotionTextLineTwo,
  //   );
  // }
}

class CarVerticalCardPromotionsData {
  String? name;
  String? code;
  CarVerticalCardPromotionsData({this.name, this.code});
}
