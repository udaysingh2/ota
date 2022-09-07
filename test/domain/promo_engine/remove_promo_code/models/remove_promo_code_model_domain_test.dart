import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String jsonStr = fixture("promo_engine/remove_promo_code_mock.json");

  RemovePromoCodeModelDomain modelDomain =
      RemovePromoCodeModelDomain.fromJson(jsonStr);

  test('RemovePromoCodeModelDomain data check model', () async {
    ///Convert in Model
    RemovePromoCodeModelDomain model = modelDomain;

    expect(model.removePromoCode != null, true);

    expect(model.removePromoCode?.data != null, true);

    ///convert in map
    Map<String, dynamic> map = model.toMap();

    RemovePromoCodeModelDomain modelMap =
        RemovePromoCodeModelDomain.fromMap(map);

    expect(modelMap.removePromoCode != null, true);

    expect(modelMap.removePromoCode?.data != null, true);

    ///Convert to json
    String json = model.toJson();
    expect(json.isNotEmpty, true);

    RemovePromoCodeModelDomain modelJson =
        RemovePromoCodeModelDomain.fromJson(json);

    expect(modelJson.removePromoCode != null, true);

    expect(modelJson.removePromoCode?.data != null, true);
  });

  test('Class RemovePromoCodeModelDomain then', () {
    RemovePromoCodeModelDomain model = modelDomain;

    expect(model.removePromoCode?.data?.removed, true);

    expect(model.removePromoCode?.data?.priceDetails?.orderPrice, 200.0);

    expect(model.removePromoCode?.data?.priceDetails?.addonPrice, 200.0);

    expect(model.removePromoCode?.data?.priceDetails?.totalAmount, 400.0);
  });
}
