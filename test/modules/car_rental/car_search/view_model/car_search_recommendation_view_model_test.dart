import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_recommendation_view_model.dart';

void main() {
  test('Car Search Recommendation View Model Tests', () async {
    CarRecommendedLocationModelState stateNone =
        CarRecommendedLocationModelState.none;

    CarRecommendedLocationViewModel model = CarRecommendedLocationViewModel(
        recommendationsState: stateNone, recommendedLocationList: []);

    expect(model.recommendationsState, stateNone);
  });
  test('Car Search Recommendation View Model Tests', () async {
    CarRecommendedLocationModelState stateNone =
        CarRecommendedLocationModelState.none;
    LocationList locationList = LocationList();
    CarRecommendedLocationModel.mapFromModel(locationList);
    CarRecommendedLocationViewModel model =
        CarRecommendedLocationViewModel(recommendedLocationList: [
      CarRecommendedLocationModel(
        cityId: "cityId",
        countryId: "countryId",
        hotelId: 'hotelId',
        placeName: 'placeName',
        playlistId: 'playlistId',
        searchKey: 'searchKey',
      )
    ], recommendationsState: stateNone);

    expect(model.recommendedLocationList.isEmpty, false);
  });
}
