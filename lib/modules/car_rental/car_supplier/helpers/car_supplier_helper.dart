import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_view_model.dart';

const String _kFreeDelivery = '146';

class CarSupplierHelper {
  static List<CarSupplierData> getCarSupplierList(
      List<SupplierDatum> supplierList) {
    List<CarSupplierData> list = [];
    for (int i = 0; i < supplierList.length; i++) {
      list.add(
        CarSupplierData(
            supplier: SupplierData.mapFromModel(supplierList[i].supplier),
            car: CarData.mapFromModel(supplierList[i].car),
            fromDate: supplierList[i].fromDate,
            toDate: supplierList[i].toDate,
            totalPrice: supplierList[i].totalPrice,
            pricePerDay: supplierList[i].pricePerDay,
            pickupCounterId: supplierList[i].pickupCounterId,
            returnCounterId: supplierList[i].returnCounterId,
            rateKey: supplierList[i].rateKey,
            refCode: supplierList[i].refCode,
            allowLateReturn: supplierList[i].allowLateReturn,
            returnExtraCharge: supplierList[i].returnExtraCharge),
      );
    }
    return list;
  }

  static List<PromotionListData> getPromotionListData(
      List<PromotionList> promotionList) {
    List<PromotionListData> list = [];
    for (int i = 0; i < promotionList.length; i++) {
      list.add(
        PromotionListData(
          productType: promotionList[i].productType,
          promotionCode: promotionList[i].promotionCode,
          title: promotionList[i].title,
          line1: promotionList[i].line1,
          line2: promotionList[i].line2,
          description: promotionList[i].description,
          web: promotionList[i].web,
        ),
      );
    }
    return list;
  }

  static List<String> getCapsulePromotionList(
      List<PromotionListData> promotionList) {
    List<String> capsulePromotionsList = [];
    for (PromotionListData item in promotionList) {
      if (item.promotionCode == _kFreeDelivery) {
        capsulePromotionsList.add(item.title ?? '');
      }
    }
    return capsulePromotionsList;
  }

  static String getCarBrandName(String brand, String name) {
    String brandWithSpace = brand.addTrailingSpace();
    return brandWithSpace + name;
  }

  static bool freeFoodFlag(bool? freeFoodDelivery) {
    return freeFoodDelivery ?? false;
  }
}
