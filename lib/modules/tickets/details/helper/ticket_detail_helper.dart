import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../../../../domain/tickets/details/models/ticket_details_model.dart';

class TicketDetailHelper {
  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<TicketDetailPromotionList> promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions.isEmpty) {
      return freeFoodPromotionList;
    }
    for (int i = 0; i < promotions.length; i++) {
      freeFoodPromotionList.add(OtaFreeFoodPromotionModel(
        headerText: promotions[i].title ?? "",
        subHeaderText: promotions[i].description ?? "",
        headerIcon: promotions[i].iconImage ?? "",
        deepLinkUrl: promotions[i].web ?? "",
        line1: promotions[i].line1 ?? "",
      ));
    }
    return freeFoodPromotionList;
  }
}
