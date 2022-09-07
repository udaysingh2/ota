import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("service_card/service_card.json");

  ServiceCardModelDomain serviceCardModelDomain =
      ServiceCardModelDomain.fromJson(json);

  GetServiceCard getServiceCard = GetServiceCard.fromJson(json);
  GetServiceCardData getServiceCardData = GetServiceCardData.fromJson(json);
  BusinessCard businessCard = BusinessCard.fromJson(json);

  test("service card Result Model Domain", () {
    ///Convert into Model
    ServiceCardModelDomain model = serviceCardModelDomain;
    expect(model.data != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    ServiceCardModelDomain mapFromModel = ServiceCardModelDomain.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    GetServiceCard model = getServiceCard;
    expect(model.data != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetServiceCard mapFromModel = GetServiceCard.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    GetServiceCardData model = getServiceCardData;
    expect(model.businessCards != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetServiceCardData mapFromModel = GetServiceCardData.fromMap(map);
    expect(mapFromModel.businessCards != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    BusinessCard model = businessCard;
    expect(model.deeplinkUrl != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    BusinessCard mapFromModel = BusinessCard.fromMap(map);
    expect(mapFromModel.deeplinkUrl != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
