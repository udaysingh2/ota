import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("car_search_suggestion/car_search_suggestion.json");
  CarSearchSuggestionData carSearchSuggestionData =
      CarSearchSuggestionData.fromJson(json);

  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    CarSearchSuggestionData model = carSearchSuggestionData;
    expect(model.getDataScienceAutoCompleteSearch != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CarSearchSuggestionData mapFromModel = CarSearchSuggestionData.fromMap(map);
    expect(mapFromModel.getDataScienceAutoCompleteSearch != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    GetDataScienceAutoCompleteSearch? model =
        carSearchSuggestionData.getDataScienceAutoCompleteSearch;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetDataScienceAutoCompleteSearch mapFromModel =
        GetDataScienceAutoCompleteSearch.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetDataScienceAutoCompleteSearch modelFromJson =
        GetDataScienceAutoCompleteSearch.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    Data? model =
        carSearchSuggestionData.getDataScienceAutoCompleteSearch?.data;
    expect(model?.suggestions != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.suggestions != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    Data modelFromJson = Data.fromJson(jsondata);
    expect(modelFromJson.suggestions != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    Suggestions? model = carSearchSuggestionData
        .getDataScienceAutoCompleteSearch?.data?.suggestions;
    expect(model?.city != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Suggestions mapFromModel = Suggestions.fromMap(map);
    expect(mapFromModel.city != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    Suggestions modelFromJson = Suggestions.fromJson(jsondata);
    expect(modelFromJson.city != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    City? model = carSearchSuggestionData
        .getDataScienceAutoCompleteSearch?.data?.suggestions?.city?.first;
    expect(model?.cityName != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    City mapFromModel = City.fromMap(map);
    expect(mapFromModel.cityName != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    City modelFromJson = City.fromJson(jsondata);
    expect(modelFromJson.cityName != null, true);
  });

  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    CityLocation? model = carSearchSuggestionData
        .getDataScienceAutoCompleteSearch
        ?.data
        ?.suggestions
        ?.cityLocation
        ?.first;
    expect(model?.locationName != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    CityLocation mapFromModel = CityLocation.fromMap(map);
    expect(mapFromModel.locationName != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    CityLocation modelFromJson = CityLocation.fromJson(jsondata);
    expect(modelFromJson.locationName != null, true);
  });
  test("car search suggestion Result Model Domain", () {
    ///Convert into Model
    Status? model =
        carSearchSuggestionData.getDataScienceAutoCompleteSearch?.status;
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
    Status modelFromJson = Status.fromJson(jsondata);
    expect(modelFromJson.code != null, true);
  });
}
