import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/models/landing_models.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("landing/landing_data.json");
  LandingData landingData = LandingData.fromJson(json);

  test("landing Data Model", () {
    ///Convert into Model
    LandingData model = landingData;
    expect(model.getLandingPageDetails != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    LandingData mapFromModel = LandingData.fromMap(map);
    expect(mapFromModel.getLandingPageDetails != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Get Landing Page Details Model", () {
    ///Convert into Model
    GetLandingPageDetails? model = landingData.getLandingPageDetails;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetLandingPageDetails mapFromModel = GetLandingPageDetails.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    //form json
    GetLandingPageDetails formJsonData =
        GetLandingPageDetails.fromJson(jsondata);
    expect(formJsonData.data != null, true);
  });

  test("Get landing Page Details Model Data ", () {
    ///Convert into Model
    GetLandingPageDetailsData? model = landingData.getLandingPageDetails?.data;
    expect(model?.backgroundUrl != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetLandingPageDetailsData mapFromModel =
        GetLandingPageDetailsData.fromMap(map);
    expect(mapFromModel.backgroundUrl != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    //form json
    GetLandingPageDetailsData formJsonData =
        GetLandingPageDetailsData.fromJson(jsondata);
    expect(formJsonData.backgroundUrl != null, true);
  });

  test("Status Model", () {
    ///Convert into Model
    Status? model = landingData.getLandingPageDetails?.status;
    expect(model?.description != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Promotions Model", () {
    final String json = fixture("landing/promotions.json");
    Promotion promotion = Promotion.fromJson(json);

    ///Convert into Model
    expect(promotion.promotionText != null, true);

    ///convert into map
    Map<String, dynamic> map = promotion.toMap();

    ///Check map conversion
    Promotion mapFromModel = Promotion.fromMap(map);
    expect(mapFromModel.promotionText != null, true);

    ///Convert to String
    String stringData = promotion.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = promotion.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Business Cards Details Model", () {
    final String json = fixture("landing/business_cards.json");

    ///Convert into Model
    BusinessCard? model = BusinessCard.fromJson(json);
    expect(model.imageUrl != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    BusinessCard mapFromModel = BusinessCard.fromJson(jsondata);
    expect(mapFromModel.imageUrl != null, true);

    String? statusJson = model.toJson();
    expect(statusJson.isNotEmpty, true);

    Status statusModel = Status.fromJson(statusJson);
    expect(statusModel.code != null, false);
  });

  test("Banner data Model", () {
    final String json = fixture("landing/banner.json");

    ///Convert into Model
    Banner? model = Banner.fromJson(json);
    expect(model.bannerId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Banner mapFromModel = Banner.fromJson(jsondata);
    expect(mapFromModel.bannerId != null, true);
  });
  test("popup data Model", () {
    final String json = fixture("landing/popup.json");

    ///Convert into Model
    Popup? model = Popup.fromJson(json);
    expect(model.popupId != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Popup mapFromModel = Popup.fromJson(jsondata);
    expect(mapFromModel.popupId != null, false);
  });

  test("Preference data Model", () {
    final String json = fixture("landing/preference.json");

    ///Convert into Model
    Preference? model = Preference.fromJson(json);
    expect(model.questionId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Preference mapFromModel = Preference.fromJson(jsondata);
    expect(mapFromModel.description1 != null, false);
  });

  test("Option data Model", () {
    final String json = fixture("landing/option.json");

    ///Convert into Model
    Option? model = Option.fromJson(json);
    expect(model.optionCode != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();
    expect(map.isNotEmpty, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Option mapFromModel = Option.fromJson(jsondata);
    expect(mapFromModel.imageUrl != null, true);
  });
}
