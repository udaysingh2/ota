import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';

void main() {
  test("Car Search Suggestion Model test", () {
    CarSearchSuggestionData carSearchSuggestionData =
        CarSearchSuggestionData.fromJson(
            CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(carSearchSuggestionData.toJson().isNotEmpty, true);
  });

  test("Car Search Suggestion Model test", () {
    GetDataScienceAutoCompleteSearch getDataScienceAutoCompleteSearch =
        GetDataScienceAutoCompleteSearch.fromJson(
            CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(getDataScienceAutoCompleteSearch.toJson().isNotEmpty, true);
  });
  test("Car Search Suggestion Model test", () {
    Data data =
        Data.fromJson(CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(data.toJson().isNotEmpty, true);
  });
  test("Car Search Suggestion Model test", () {
    Suggestions suggestions = Suggestions.fromJson(
        CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(suggestions.toJson().isNotEmpty, true);
  });
  test("Car Search Suggestion Model test", () {
    City city =
        City.fromJson(CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(city.toJson().isNotEmpty, true);
  });
  test("Car Search Suggestion Model test", () {
    CityLocation cityLocation = CityLocation.fromJson(
        CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(cityLocation.toJson().isNotEmpty, true);
  });
  test("Car Search Suggestion Model test", () {
    Status status =
        Status.fromJson(CarSearchSuggestionMockDataSourceImpl.getMockData());
    expect(status.toJson().isNotEmpty, true);
  });
}
