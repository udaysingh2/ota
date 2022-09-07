import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_search_history_view_model.dart';

void main() {
  test('Car Search History View Model Tests', () async {
    CarSearchHistoryViewModelState stateNone =
        CarSearchHistoryViewModelState.none;

    CarSearchHistoryViewModel model = CarSearchHistoryViewModel(
        searchHistoryList: [], recommendationState: stateNone);

    expect(model.recommendationState, stateNone);
  });
  test('Car Search History View Model Tests', () async {
    CarSearchHistoryViewModelState stateNone =
        CarSearchHistoryViewModelState.none;
    CarRecentSearchList searchHistory = CarRecentSearchList();
    CarRentalSearchHistoryModel.mapFromModel(searchHistory);
    CarSearchHistoryViewModel model =
        CarSearchHistoryViewModel(searchHistoryList: [
      CarRentalSearchHistoryModel(
          cityId: "cityId",
          countryId: "countryId",
          createdDate: "createdDate",
          keyword: "keyword",
          placeId: "placeId")
    ], recommendationState: stateNone);

    expect(model.searchHistoryList.isEmpty, false);
  });
}
