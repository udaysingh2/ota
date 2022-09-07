import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';

import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_recommendation_view_model.dart';

import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';
import '../view/widget/car_search_suggestion_tile_widget.dart';

const String _kLocationKey = "LOCATION";
const String _kCityLocationKey = "CITY";

class CarSearchSuggestionsHelper {
  static String getServiceType(ServiceType type) {
    switch (type) {
      case ServiceType.location:
        return _kLocationKey;
      case ServiceType.city:
        return _kCityLocationKey;
    }
  }

  static List<Item> getSuggestionItemList(List<CityLocation>? list) {
    if (list != null && list.isNotEmpty) {
      return List.generate(list.length, (index) => Item.from(list[index]));
    } else {
      return [];
    }
  }

  static List<CityItem> getSuggestionCityItemList(List<City>? list) {
    if (list != null && list.isNotEmpty) {
      return List.generate(list.length, (index) => CityItem.from(list[index]));
    } else {
      return [];
    }
  }

  static List<CarRecommendedLocationModel>? getHotelRecommendationViewModel(
      List<LocationList>? locations) {
    List<CarRecommendedLocationModel>? recommendedLocationList;
    if (locations == null || locations.isEmpty) {
      return recommendedLocationList;
    }
    recommendedLocationList = List<CarRecommendedLocationModel>.generate(
        locations.length,
        (index) => CarRecommendedLocationModel.mapFromModel(locations[index]));
    return recommendedLocationList;
  }
}
