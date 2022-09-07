import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("search/search_recommendation.json");
  SearchRecommendationModel searchRecommendationModel =
      SearchRecommendationModel.fromJson(json);

  test("Search Recommendation Model", () {
    ///Convert into Model
    SearchRecommendationModel model = searchRecommendationModel;
    expect(model.getSearchRecommendation != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    SearchRecommendationModel mapFromModel =
        SearchRecommendationModel.fromMap(map);
    expect(mapFromModel.getSearchRecommendation != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Get Search Recommendation Model", () {
    ///Convert into Model
    GetSearchRecommendation? model =
        searchRecommendationModel.getSearchRecommendation;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetSearchRecommendation mapFromModel = GetSearchRecommendation.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetSearchRecommendation modelFromJson =
        GetSearchRecommendation.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });

  test("Get Search Recommendation Data", () {
    ///Convert into Model
    GetSearchRecommendationData? model =
        searchRecommendationModel.getSearchRecommendation?.data;
    expect(model?.recommendations != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetSearchRecommendationData mapFromModel =
        GetSearchRecommendationData.fromMap(map);
    expect(mapFromModel.recommendationKey != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetSearchRecommendationData modelFromJson =
        GetSearchRecommendationData.fromJson(jsondata);
    expect(modelFromJson.recommendationKey != null, true);
  });

  test("Recommendations Model", () {
    ///Convert into Model
    Recommendation? model = searchRecommendationModel
        .getSearchRecommendation?.data?.recommendations?[0];
    expect(model?.serviceTitle != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Recommendation mapFromModel = Recommendation.fromMap(map);
    expect(mapFromModel.serviceTitle != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Recommendation modelFromJson = Recommendation.fromJson(jsondata);
    expect(modelFromJson.serviceTitle != null, true);
  });

  test("Search History Model", () {
    ///Convert into Model
    SearchHistory? model = searchRecommendationModel
        .getSearchRecommendation?.data?.searchHistory?[0];
    expect(model?.keyword != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    SearchHistory mapFromModel = SearchHistory.fromMap(map);
    expect(mapFromModel.keyword != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    SearchHistory modelFromJson = SearchHistory.fromJson(jsondata);
    expect(modelFromJson.keyword != null, true);
  });

  test("Status Model", () {
    ///Convert into Model
    Status? model = searchRecommendationModel.getSearchRecommendation?.status;
    expect(model?.code != null, true);

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

    ///Check map conversion
    Status modelFromJson = Status.fromJson(jsondata);
    expect(modelFromJson.code != null, true);
  });
}
