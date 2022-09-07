import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

class RecommendedLocationViewModel {
  List<RecommendedLocationModel> recommendedLocationList;
  RecommendedLocationModelState recommendationsState;

  RecommendedLocationViewModel({
    required this.recommendedLocationList,
    required this.recommendationsState,
  });
}

class RecommendedLocationModel {
  final String playlistId;
  final String hotelId;
  final String cityId;
  final String countryId;
  final String? imageUrl;
  final String searchKey;
  final String placeName;

  RecommendedLocationModel({
    required this.playlistId,
    required this.hotelId,
    required this.cityId,
    required this.countryId,
    this.imageUrl,
    required this.placeName,
    required this.searchKey,
  });

  factory RecommendedLocationModel.mapFromModel(LocationList locationList) =>
      RecommendedLocationModel(
        playlistId: locationList.playlistId ?? '',
        cityId: locationList.cityId ?? '',
        countryId: locationList.countryId ?? '',
        placeName: locationList.serviceTitle ?? '',
        hotelId: locationList.hotelId ?? '',
        imageUrl: locationList.imageUrl ?? '',
        searchKey: locationList.searchKey ?? '',
      );
}

enum RecommendedLocationModelState {
  none,
  loading,
  success,
  failure,
}
