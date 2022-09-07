import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String jsonStr = fixture("promo_engine/public_promo_code_mock.json");
  List<PromotionList> promotionList = [
    PromotionList(
      promotionId: 1,
      applicationKey: 'HOTEL',
      promotionName: "RBH Special",
      shortDescription: "ส่วนลดมูลค่า 50 บาท",
      discount: 50.00,
      maximumDiscount: 100.00,
      discountType: "PERCENT",
      discountFor: "ORDER",
      promotionLink: "scbeasy://payments/creditcard/review/id/4567",
      promotionType: "PUBLIC",
      iconUrl: "scbeasy://payments/creditcard/review/id/4567",
      voucherCode: "RBH50",
      promotionCode: "RBH50",
      startDate: "2020-07-24T08:44:39.000Z",
      endDate: "2020-07-24T08:44:39.000Z",
    ),
  ];
  PublicPromotionModelDomain modelDomain =
      PublicPromotionModelDomain.fromJson(jsonStr);

  test('PublicPromotionModelDomain data check model', () async {
    ///Convert in Model
    PublicPromotionModelDomain model = modelDomain;

    expect(model.getAvailablePublicPromotions != null, true);

    expect(model.getAvailablePublicPromotions?.data != null, true);

    ///convert in map
    Map<String, dynamic> map = model.toMap();

    PublicPromotionModelDomain modelMap =
        PublicPromotionModelDomain.fromMap(map);

    expect(modelMap.getAvailablePublicPromotions != null, true);

    expect(modelMap.getAvailablePublicPromotions?.data != null, true);

    ///Convert to json
    String json = model.toJson();
    expect(json.isNotEmpty, true);

    PublicPromotionModelDomain modelJson =
        PublicPromotionModelDomain.fromJson(json);

    expect(modelJson.getAvailablePublicPromotions != null, true);

    expect(modelJson.getAvailablePublicPromotions?.data != null, true);
  });

  test('Class PublicPromotionModelDomain then', () {
    PublicPromotionModelDomain model = modelDomain;

    expect(
        model.getAvailablePublicPromotions?.data?.pagination?.currentPage, 0);

    expect(model.getAvailablePublicPromotions?.data?.pagination?.pageSize, 20);

    expect(model.getAvailablePublicPromotions?.data?.pagination?.hasNextPage,
        true);
    expect(
        model.getAvailablePublicPromotions?.data?.pagination?.hasPreviousPage,
        false);

    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].discount,
      promotionList[0].discount,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].promotionId,
      promotionList[0].promotionId,
    );
    expect(
      model
          .getAvailablePublicPromotions?.data?.promotionList![0].applicationKey,
      promotionList[0].applicationKey,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].promotionName,
      promotionList[0].promotionName,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0]
          .shortDescription,
      promotionList[0].shortDescription,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].discount,
      promotionList[0].discount,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0]
          .maximumDiscount,
      promotionList[0].maximumDiscount,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].discountType,
      promotionList[0].discountType,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].discountFor,
      promotionList[0].discountFor,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].promotionLink,
      promotionList[0].promotionLink,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].promotionType,
      promotionList[0].promotionType,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].iconUrl,
      promotionList[0].iconUrl,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].voucherCode,
      promotionList[0].voucherCode,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].promotionCode,
      promotionList[0].promotionCode,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].startDate,
      promotionList[0].startDate,
    );
    expect(
      model.getAvailablePublicPromotions?.data?.promotionList![0].endDate,
      promotionList[0].endDate,
    );
  });
}
