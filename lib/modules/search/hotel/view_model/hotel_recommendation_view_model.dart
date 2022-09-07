import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';

class HotelRecommendationViewModel {
  List<HotelRecommendationModel> recommendationList;
  List<HotelSearchHistoryModel> searchHistoryList;
  HotelRecommendationViewModelState recommendationState;

  HotelRecommendationViewModel({
    required this.recommendationList,
    required this.searchHistoryList,
    this.recommendationState = HotelRecommendationViewModelState.none,
  });
}

class HotelRecommendationModel {
  String? playListId;
  String serviceTitle;
  String? hotelId;
  String? countryId;
  String? cityId;
  String imageUrl;

  HotelRecommendationModel({
    this.playListId,
    required this.serviceTitle,
    this.cityId,
    this.hotelId,
    this.countryId,
    required this.imageUrl,
  });

  factory HotelRecommendationModel.mapFromModel(
          Recommendation recommendation) =>
      HotelRecommendationModel(
        playListId: recommendation.playlistId,
        cityId: recommendation.cityId,
        countryId: recommendation.countryId,
        serviceTitle: recommendation.serviceTitle ?? '',
        hotelId: recommendation.hotelId,
        imageUrl: recommendation.imageUrl ?? '',
      );

  factory HotelRecommendationModel.mapFromHotelModel(
          HotelRecommendation recommendation) =>
      HotelRecommendationModel(
        playListId: recommendation.playlistId,
        cityId: recommendation.cityId,
        countryId: recommendation.countryId,
        serviceTitle: recommendation.serviceTitle ?? '',
        hotelId: recommendation.hotelId,
        imageUrl: recommendation.imageUrl ?? '',
      );
}

class HotelSearchHistoryModel {
  String keyword;
  String? checkInDate;
  String? checkOutDate;
  String? hotelId;
  String? countryId;
  String? cityId;
  String? locationId;

  HotelSearchHistoryModel({
    required this.keyword,
    this.checkInDate,
    this.checkOutDate,
    this.cityId,
    this.hotelId,
    this.countryId,
    this.locationId,
  });

  factory HotelSearchHistoryModel.mapFromModel(SearchHistory searchHistory) =>
      HotelSearchHistoryModel(
        keyword: searchHistory.keyword ?? '',
        checkInDate: searchHistory.checkInDate,
        checkOutDate: searchHistory.checkOutDate,
        cityId: searchHistory.cityId,
        hotelId: searchHistory.hotelId,
        countryId: searchHistory.countryId,
        locationId: searchHistory.locationId,
      );

  factory HotelSearchHistoryModel.mapFromHotelModel(
          HotelSearchHistory searchHistory) =>
      HotelSearchHistoryModel(
        keyword: searchHistory.keyword ?? '',
        checkInDate: searchHistory.checkInDate,
        checkOutDate: searchHistory.checkOutDate,
        cityId: searchHistory.cityId,
        hotelId: searchHistory.hotelId,
        countryId: searchHistory.countryId,
        locationId: searchHistory.locationId,
      );
}

enum HotelRecommendationViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
