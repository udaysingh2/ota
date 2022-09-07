import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

class CarRecommendedLocationViewModel {
  List<CarRecommendedLocationModel> recommendedLocationList;
  CarRecommendedLocationModelState recommendationsState;

  CarRecommendedLocationViewModel({
    required this.recommendedLocationList,
    required this.recommendationsState,
  });
}

class CarRecommendedLocationModel {
  final String playlistId;
  final String hotelId;
  final String cityId;
  final String countryId;
  final String? imageUrl;
  final String searchKey;
  final String placeName;

  CarRecommendedLocationModel({
    required this.playlistId,
    required this.hotelId,
    required this.cityId,
    required this.countryId,
    this.imageUrl,
    required this.placeName,
    required this.searchKey,
  });

  factory CarRecommendedLocationModel.mapFromModel(LocationList locationList) =>
      CarRecommendedLocationModel(
        playlistId: locationList.playlistId ?? '',
        cityId: locationList.cityId ?? '',
        countryId: locationList.countryId ?? '',
        placeName: locationList.serviceTitle ?? '',
        hotelId: locationList.hotelId ?? '',
        imageUrl: locationList.imageUrl ?? '',
        searchKey: locationList.searchKey ?? '',
      );
}

enum CarRecommendedLocationModelState {
  none,
  loading,
  success,
  failure,
  failureNetwork,
}
