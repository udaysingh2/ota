import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_argument_view_model.dart';

class CarRentalVerticalHelper {
  static List<CarVerticalCardPromotionsData>? getCapsulePromotionList(List<CapsulePromotion> promotionList){
    List<CarVerticalCardPromotionsData> capsulePromotionsList = [];
    for (CapsulePromotion item in promotionList){
      capsulePromotionsList.add(CarVerticalCardPromotionsData(name: item.name, code: item.code));
    }
    return capsulePromotionsList;
  }

  static List<CarVerticalArgumentViewModel>? getCarVerticalCardViewModelList(List<CarModelList> carModelList, Counter? suggestionModel){
    List<CarVerticalArgumentViewModel> carModelListData = [];
    for (CarModelList item in carModelList){
      carModelListData.add(CarVerticalArgumentViewModel.fromCard(item, suggestionModel));
    }
    return carModelListData;
  }

}