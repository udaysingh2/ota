import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("promo_engine/apply_promo_mock.json");
  ApplyPromoModelDomain applyPromoResultModel =
      ApplyPromoModelDomain.fromJson(jsonString);
  ApplyPromoCode applyPromoCode = ApplyPromoCode.fromJson(jsonString);

  Status status = Status.fromJson(jsonString);

  test("Apply Promo Models", () {
    //Convert into Model
    expect(applyPromoResultModel.applyPromoCode != null, true);

    //convert into map
    Map<String, dynamic> map = applyPromoResultModel.toMap();

    ///Check map conversion
    ApplyPromoModelDomain mapFromModel = ApplyPromoModelDomain.fromMap(map);

    expect(mapFromModel.applyPromoCode != null, true);

    ///Convert to String
    String stringData = applyPromoResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = applyPromoResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Data data =
        Data.fromJson(applyPromoResultModel.applyPromoCode!.data!.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.bookingUrn != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Status test ", () {
    ///Convert into Model
    Status model = status;
    expect(model.code == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Apply Promo test ", () {
    ///Convert into Model
    ApplyPromoCode model = applyPromoCode;
    expect(model.data == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    ApplyPromoCode mapFromModel = ApplyPromoCode.fromMap(map);
    expect(mapFromModel.data == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
