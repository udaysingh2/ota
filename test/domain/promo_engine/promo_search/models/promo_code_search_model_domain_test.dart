import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String jsonStr = fixture("promo_engine/promo_code_search_mock.json");

  PromoCodeSearchModelDomain modelDomain =
  PromoCodeSearchModelDomain.fromJson(jsonStr);

  test('RemovePromoCodeModelDomain data check model', () async {
    ///Convert in Model
    PromoCodeSearchModelDomain model = modelDomain;

    expect(model.searchPromoCode != null, true);

    expect(model.searchPromoCode?.data != null, true);

    ///convert in map
    Map<String, dynamic> map = model.toMap();

    PromoCodeSearchModelDomain modelMap =
    PromoCodeSearchModelDomain.fromMap(map);

    expect(modelMap.searchPromoCode != null, true);

    expect(modelMap.searchPromoCode?.data != null, true);

    ///Convert to json
    String json = model.toJson();
    expect(json.isNotEmpty, true);

    PromoCodeSearchModelDomain modelJson =
    PromoCodeSearchModelDomain.fromJson(json);

    expect(modelJson.searchPromoCode != null, true);

    expect(modelJson.searchPromoCode?.data != null, true);
  });

  test('Class PromoCodeSearchModelDomain then', () {
    PromoCodeSearchModelDomain model = modelDomain;

    expect(model.searchPromoCode?.data?.promotionId, 1);
    expect(model.searchPromoCode?.data?.promotionName, 'RBH Special');
    expect(model.searchPromoCode?.data?.promotionCode, 'RBH50');
    expect(model.searchPromoCode?.data?.shortDescription, 'ส่วนลดมูลค่า 50 บาท');
    expect(model.searchPromoCode?.data?.promotionLink, 'scbeasy://payments/creditcard/review/id/4567');
    expect(model.searchPromoCode?.data?.discount, 50.0);
    expect(model.searchPromoCode?.data?.maximumDiscount, 100.0);
    expect(model.searchPromoCode?.data?.discountType, 'PERCENT');

  });
}
