import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("car_detail/car_detail.json");
  CarDetailDomainModel carDetailDomainModel =
      CarDetailDomainModel.fromJson(json);
  Promotion promotion = Promotion.fromJson(json);

  test("car detail Result Model Domain", () {
    ///Convert into Model
    CarDetailDomainModel model = carDetailDomainModel;
    expect(model.carDetailInfo != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test("car detail Result Model Domain", () {
    ///Convert into Model
    CarDetailInfo? model = carDetailDomainModel.carDetailInfo;
    expect(model?.carInfo != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test("car detail Result Model Domain", () {
    ///Convert into Model
    CarDetail? model = carDetailDomainModel.carDetailInfo?.carDeatil;
    expect(model?.promotions != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test("car detail Result Model Domain", () {
    ///Convert into Model
    CarDetail? model = carDetailDomainModel.carDetailInfo?.carDeatil;
    expect(model?.promotions != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
  test("car detail Result Model Domain", () {
    Promotion model = promotion;
    expect(model.title != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Promotion mapFromModel = Promotion.fromMap(map);
    expect(mapFromModel.iconImage != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
