import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData =
      fixture("car_save_search_history/car_save_search_history.json");
  CarSaveSearchHistoryModelDomain carSaveSearchHistoryModelDomain =
      CarSaveSearchHistoryModelDomain.fromJson(jsonData);
  test("Car Save Search History Domain Model Test", () {
    String stringData = carSaveSearchHistoryModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = carSaveSearchHistoryModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Car Save Search History", () {
    String jsonData =
        fixture("car_save_search_history/car_save_search_history.json");

    SaveRecentCarRentalSearchHistory saveRecentCarRentalSearchHistory =
        SaveRecentCarRentalSearchHistory.fromJson(jsonData);
    Map<String, dynamic> map = saveRecentCarRentalSearchHistory.toMap();

    SaveRecentCarRentalSearchHistory mapFromModel =
        SaveRecentCarRentalSearchHistory.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Car Save Search Status", () {
    String jsonData =
        fixture("car_save_search_history/car_save_search_history.json");

    Status status = Status.fromJson(jsonData);
    Map<String, dynamic> map = status.toMap();

    Status mapFromModel = Status.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
}
