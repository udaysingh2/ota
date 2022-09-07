import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';

void main() {
  group('For RecommendedLocationViewModel class', () {
    test(
        'For Argument -> recommendedLocationList In RecommendedLocationViewModel class',
        () {
      final actual = getRecommendedLocationViewModel();

      expect(actual.recommendedLocationList.isNotEmpty, true);
      expect(actual.recommendedLocationList.length, 1);
      expect(actual.recommendedLocationList[0].playlistId.isNotEmpty, true);
      expect(actual.recommendedLocationList[0].playlistId, '007');
      expect(actual.recommendedLocationList[0].hotelId, 'MA0511000344');
      expect(actual.recommendedLocationList[0].placeName, 'Thailand');
      expect(actual.recommendedLocationList[0].searchKey, 'hotel');
    });

    test(
        'For Argument -> recommendationsState In RecommendedLocationViewModel class',
        () {
      final actual = getRecommendedLocationViewModel();

      expect(actual.recommendationsState != RecommendedLocationModelState.none,
          true);
      expect(actual.recommendationsState.index, 2);
      expect(
          actual.recommendationsState, RecommendedLocationModelState.success);
    });
  });

  test('For RecommendedLocationModel factory class', () {
    final actual = RecommendedLocationModel.mapFromModel(getLocationList());

    expect(actual.playlistId.isNotEmpty, true);
    expect(actual.playlistId, '111');
    expect(actual.hotelId.isNotEmpty, true);
    expect(actual.hotelId, 'MA0511000344');
    expect(actual.cityId, 'MA05110041');
    expect(actual.countryId, 'MA05110001');
    expect(actual.searchKey, 'hotel');
    expect(actual.imageUrl?.isEmpty, true);
  });
}

RecommendedLocationViewModel getRecommendedLocationViewModel() {
  return RecommendedLocationViewModel(
    recommendedLocationList: [
      RecommendedLocationModel(
          playlistId: '007',
          hotelId: 'MA0511000344',
          cityId: 'MA05110041',
          countryId: 'MA05110001',
          placeName: 'Thailand',
          searchKey: 'hotel'),
    ],
    recommendationsState: RecommendedLocationModelState.success,
  );
}

LocationList getLocationList() {
  return LocationList(
    playlistId: '111',
    hotelId: 'MA0511000344',
    cityId: 'MA05110041',
    countryId: 'MA05110001',
    searchKey: 'hotel',
    imageUrl: '',
    serviceTitle: 'Deluxe Double',
  );
}
