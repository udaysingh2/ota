import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/helpers/car_search_suggestion_helper.dart';

class CarSearchSuggestionsViewModel {
  CarSearchSuggestionsViewModelState suggestionsState;
  List<Item>? location;
  List<CityItem>? city;

  CarSearchSuggestionsViewModel({
    this.suggestionsState = CarSearchSuggestionsViewModelState.none,
    this.location,
    this.city,
  });

  factory CarSearchSuggestionsViewModel.fromData(
          {required GetDataScienceAutoCompleteSearch data}) =>
      CarSearchSuggestionsViewModel(
        location: CarSearchSuggestionsHelper.getSuggestionItemList(
            data.data?.suggestions?.location),
        city: CarSearchSuggestionsHelper.getSuggestionCityItemList(
            data.data?.suggestions?.city),
      );
}

class Item {
  Item({
    this.keyword,
    this.countryId,
    this.cityId,
    this.id,
    this.locationName,
  });

  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? id;
  final String? locationName;

  factory Item.from(CityLocation item) => Item(
      keyword: item.keyword,
      countryId: item.countryId,
      cityId: item.cityId,
      id: item.id,
      locationName: item.locationName);
}

class CityItem {
  CityItem({
    this.keyword,
    this.cityId,
    this.cityName,
    this.countryId,
  });

  final String? keyword;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  factory CityItem.from(City item) => CityItem(
        keyword: item.keyword,
        countryId: item.countryId,
        cityId: item.cityId,
        cityName: item.cityName,
      );
}

enum CarSearchSuggestionsViewModelState {
  none,
  loading,
  success,
  failure,
  failureNetwork,
}
