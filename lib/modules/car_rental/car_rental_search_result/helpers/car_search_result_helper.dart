import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';

class CarSearchResultHelper {
  static List<String> getCapsulePromotionList(
      List<PromotionModel> promotionList) {
    List<String> capsulePromotionsList = [];
    for (PromotionModel item in promotionList) {
      capsulePromotionsList.add(item.name ?? '');
    }
    return capsulePromotionsList;
  }

  static String getConcatenatedString(List<String> carInfoList) {
    if (carInfoList.isNotEmpty) {
      String resultString = '';
      for (int i = 0; i < carInfoList.length; i++) {
        resultString = "$resultString,$carInfoList[i]";
      }
      return resultString;
    }
    return '';
  }
}
