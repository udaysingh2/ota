import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/helpers/car_search_suggestion_helper.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

void main() {
  test('Car Search Suggestion View Model Tests', () async {
    CarSearchSuggestionsViewModelState stateNone =
        CarSearchSuggestionsViewModelState.none;

    GetDataScienceAutoCompleteSearch model = GetDataScienceAutoCompleteSearch();
    CarSearchSuggestionsViewModel.fromData(data: model);
    CarSearchSuggestionsViewModel viewModel = CarSearchSuggestionsViewModel();
    expect(viewModel.suggestionsState, stateNone);
  });
  test('Car Search Suggestion View Model Tests', () async {
    CarSearchSuggestionsViewModelState stateNone =
        CarSearchSuggestionsViewModelState.none;
    CityLocation cityLocation = CityLocation();
    City city = City();
    Item.from(cityLocation);
    CityItem.from(city);
    CarSearchSuggestionsViewModel model = CarSearchSuggestionsViewModel(
        city: CarSearchSuggestionsHelper.getSuggestionCityItemList([city]),
        location:
            CarSearchSuggestionsHelper.getSuggestionItemList([cityLocation]));

    expect(model.suggestionsState, stateNone);
  });
}
