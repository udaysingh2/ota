import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData = fixture("car_search_history/car_search_history.json");
  CarSearchHistoryModelDomain carSearchHistoryModelDomain =
      CarSearchHistoryModelDomain.fromJson(jsonData);
  test("Car Search History Domain Model Test", () {
    String stringData = carSearchHistoryModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = carSearchHistoryModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Car Search History", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    CarSearchHistoryModelDomainData carSearchHistoryModelDomainData =
        CarSearchHistoryModelDomainData.fromString(jsonData);
    Map<String, dynamic> map = carSearchHistoryModelDomainData.toMap();

    CarSearchHistoryModelDomainData mapFromModel =
        CarSearchHistoryModelDomainData.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Search History", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    GetCarRentalRecentSearches recentCarRentalSearchHistory =
        GetCarRentalRecentSearches.fromJson(jsonData);
    Map<String, dynamic> map = recentCarRentalSearchHistory.toMap();

    GetCarRentalRecentSearches mapFromModel =
        GetCarRentalRecentSearches.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Search History", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    GetCarRentalRecentSearchesData getCarRentalRecentSearchesData =
        GetCarRentalRecentSearchesData.fromJson(jsonData);
    Map<String, dynamic> map = getCarRentalRecentSearchesData.toMap();

    GetCarRentalRecentSearchesData mapFromModel =
        GetCarRentalRecentSearchesData.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Search History", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    SearchHistory searchHistory = SearchHistory.fromJson(jsonData);
    Map<String, dynamic> map = searchHistory.toMap();

    SearchHistory mapFromModel = SearchHistory.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Search History", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    CarRental carRental = CarRental.fromJson(jsonData);
    Map<String, dynamic> map = carRental.toMap();

    CarRental mapFromModel = CarRental.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Search History", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    CarRecentSearchList carRentalList = CarRecentSearchList.fromJson(jsonData);
    Map<String, dynamic> map = carRentalList.toMap();

    CarRecentSearchList mapFromModel = CarRecentSearchList.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Search Status", () {
    String jsonData = fixture("car_search_history/car_search_history.json");

    Status status = Status.fromJson(jsonData);
    Map<String, dynamic> map = status.toMap();

    Status mapFromModel = Status.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
}
