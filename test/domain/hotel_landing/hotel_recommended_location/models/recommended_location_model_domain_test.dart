import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("hotel_landing/hotel_recommended_location/hotel_recommend.json");
  RecommendedLocationModelDomain recommendedLocationModelDomain =
      RecommendedLocationModelDomain.fromJson(json);
  GetRecommendedLocation getRecommendedLocation =
      GetRecommendedLocation.fromJson(json);

  LocationList locationList = LocationList.fromJson(json);
  Data data = Data.fromJson(json);
  Status status = Status.fromJson(json);

  test("Recommended Location Model Domain", () {
    ///Convert into Model
    RecommendedLocationModelDomain model = recommendedLocationModelDomain;
    expect(model.getRecommendedLocation != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RecommendedLocationModelDomain mapFromModel =
        RecommendedLocationModelDomain.fromMap(map);
    expect(mapFromModel.getRecommendedLocation != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Recommended Location Model", () {
    ///Convert into Model
    GetRecommendedLocation model = getRecommendedLocation;
    expect(model.data != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetRecommendedLocation mapFromModel = GetRecommendedLocation.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Recommended Location Model Data", () {
    ///Convert into Model
    Data model = data;
    expect(model.locationList != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.locationList != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Recommended Location Model Locations", () {
    ///Convert into Model
    LocationList model = locationList;
    expect(model.imageUrl != null, false);
    expect(model.serviceTitle != null, false);
    expect(model.cityId != null, false);
    expect(model.hotelId != null, false);
    expect(model.playlistId != null, false);
    expect(model.countryId != null, false);
    expect(model.searchKey != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.locationList != null, false);
    expect(model.imageUrl != null, false);
    expect(model.serviceTitle != null, false);
    expect(model.cityId != null, false);
    expect(model.hotelId != null, false);
    expect(model.playlistId != null, false);
    expect(model.countryId != null, false);
    expect(model.searchKey != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
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
}
