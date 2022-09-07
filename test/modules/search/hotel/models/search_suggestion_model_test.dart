import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("search/search_suggestion.json");
  SearchSuggestionModel searchSuggestionModel =
      SearchSuggestionModel.fromJson(json);

  test("Search Suggestion Model", () {
    ///Convert into Model
    SearchSuggestionModel model = searchSuggestionModel;
    expect(model.getDataScienceAutoCompleteSearch != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    SearchSuggestionModel mapFromModel = SearchSuggestionModel.fromMap(map);
    expect(mapFromModel.getDataScienceAutoCompleteSearch != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Get Search Suggestion Model", () {
    ///Convert into Model
    GetDataScienceAutoCompleteSearch? model =
        searchSuggestionModel.getDataScienceAutoCompleteSearch;
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

    ///Check map conversion
    GetDataScienceAutoCompleteSearch modelFromJson =
        GetDataScienceAutoCompleteSearch.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });

  test("Get Search Suggestion Data", () {
    ///Convert into Model
    GetDataScienceAutoCompleteSearchData? model =
        searchSuggestionModel.getDataScienceAutoCompleteSearch?.data;
    expect(model?.suggestions != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetDataScienceAutoCompleteSearchData mapFromModel =
        GetDataScienceAutoCompleteSearchData.fromMap(map);
    expect(mapFromModel.suggestions != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    GetDataScienceAutoCompleteSearchData modelFromJson =
        GetDataScienceAutoCompleteSearchData.fromJson(jsondata);
    expect(modelFromJson.suggestions != null, true);
  });

  test("Suggestions Model", () {
    ///Convert into Model
    Suggestions? model = searchSuggestionModel
        .getDataScienceAutoCompleteSearch?.data?.suggestions;
    expect(model?.city != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Suggestions mapFromModel = Suggestions.fromMap(map);
    expect(mapFromModel.hotel != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Suggestions modelFromJson = Suggestions.fromJson(jsondata);
    expect(modelFromJson.hotel != null, true);
  });
}
