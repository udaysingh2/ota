import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("search/hotel_recommendation.json");
  HotelRecommendationModelDomain hotelRecommendationModelDomain =
      HotelRecommendationModelDomain.fromJson(json);

  test("hotel Recommendation Model Domain test", () {
    ///Convert into Model
    HotelRecommendationModelDomain model = hotelRecommendationModelDomain;
    expect(model.getHotelSearchRecommendation != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelRecommendationModelDomain mapFromModel =
        HotelRecommendationModelDomain.fromMap(map);
    expect(mapFromModel.getHotelSearchRecommendation != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetHotelSearchRecommendation test", () {
    ///Convert into Model
    GetHotelSearchRecommendation? model =
        hotelRecommendationModelDomain.getHotelSearchRecommendation;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic>? map = model?.toMap();

    ///Check map conversion
    GetHotelSearchRecommendation mapFromModel =
        GetHotelSearchRecommendation.fromMap(map!);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String? jsondata = model?.toJson();
    expect(jsondata?.isNotEmpty, true);
  });

  test("HotelSearchHistory test", () {
    ///Convert into Model
    HotelSearchHistory? model = HotelSearchHistory();
    expect(model.hotelId != null, false);

    ///convert into map
    Map<String, dynamic>? map = model.toMap();

    ///Check map conversion
    GetHotelSearchRecommendation mapFromModel =
        GetHotelSearchRecommendation.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String? jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("HotelSearchHistory test", () {
    ///Convert into Model
    HotelRecommendation? model = HotelRecommendation();
    expect(model.hotelId != null, false);

    ///convert into map
    Map<String, dynamic>? map = model.toMap();

    ///Check map conversion
    HotelRecommendation mapFromModel = HotelRecommendation.fromMap(map);
    expect(mapFromModel.hotelId != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String? jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Status test", () {
    ///Convert into Model
    Status? model =
        hotelRecommendationModelDomain.getHotelSearchRecommendation?.status;
    expect(model?.code != null, true);

    ///convert into map
    Map<String, dynamic>? map = model?.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map!);
    expect(mapFromModel.code != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String? jsondata = model?.toJson();
    expect(jsondata?.isNotEmpty, true);
  });

  test("Data test", () {
    ///Convert into Model
    Data? model =
        hotelRecommendationModelDomain.getHotelSearchRecommendation?.data;
    expect(model?.recommendations != null, true);

    ///convert into map
    Map<String, dynamic>? map = model?.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map!);
    expect(mapFromModel.recommendations != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String? jsondata = model?.toJson();
    expect(jsondata?.isNotEmpty, true);
  });
}
