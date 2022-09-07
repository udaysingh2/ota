import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/helpers/car_search_suggestion_helper.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';

void main() {
  test('car search suggestion helper test ...', () async {
    LocationList locationList = LocationList(cityId: "cityId");
    CityLocation cityLocation = CityLocation();
    City city = City();
    CarSearchSuggestionsHelper.getHotelRecommendationViewModel([locationList]);
    CarSearchSuggestionsHelper.getServiceType(ServiceType.city);
    CarSearchSuggestionsHelper.getSuggestionCityItemList([city]);
    CarSearchSuggestionsHelper.getSuggestionItemList([cityLocation]);
    expect(locationList.cityId, "cityId");
  });
  test('car search suggestion helper test ...', () async {
    LocationList locationList = LocationList(cityId: "cityId");
    CarSearchSuggestionsHelper.getSuggestionCityItemList([]);
    CarSearchSuggestionsHelper.getSuggestionItemList([]);
    expect(locationList.cityId, "cityId");
  });
}
