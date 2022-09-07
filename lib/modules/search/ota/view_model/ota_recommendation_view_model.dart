import 'package:ota/domain/search/models/search_recommendation_model.dart';

class OtaRecommendationViewModel {
  List<OtaRecommendationModel> recommendationList;
  List<OtaSearchHistoryModel> searchHistoryList;
  OtaRecommendationViewModelState recommendationState;

  OtaRecommendationViewModel({
    required this.recommendationList,
    required this.searchHistoryList,
    this.recommendationState = OtaRecommendationViewModelState.none,
  });
}

class OtaRecommendationModel {
  String? playListId;
  String serviceTitle;
  String? hotelId;
  String? countryId;
  String? cityId;
  String imageUrl;

  OtaRecommendationModel({
    this.playListId,
    required this.serviceTitle,
    this.cityId,
    this.hotelId,
    this.countryId,
    required this.imageUrl,
  });

  factory OtaRecommendationModel.mapFromModel(Recommendation recommendation) =>
      OtaRecommendationModel(
        playListId: recommendation.playlistId,
        cityId: recommendation.cityId,
        countryId: recommendation.countryId,
        serviceTitle: recommendation.serviceTitle ?? '',
        hotelId: recommendation.hotelId,
        imageUrl: recommendation.imageUrl ?? '',
      );
}

class OtaSearchHistoryModel {
  String keyword;
  String? checkInDate;
  String? checkOutDate;
  String? hotelId;
  String? countryId;
  String? cityId;
  String? locationId;

  OtaSearchHistoryModel({
    required this.keyword,
    this.checkInDate,
    this.checkOutDate,
    this.cityId,
    this.hotelId,
    this.countryId,
    this.locationId,
  });

  factory OtaSearchHistoryModel.mapFromModel(SearchHistory searchHistory) =>
      OtaSearchHistoryModel(
        keyword: searchHistory.keyword ?? '',
        checkInDate: searchHistory.checkInDate,
        checkOutDate: searchHistory.checkOutDate,
        cityId: searchHistory.cityId,
        hotelId: searchHistory.hotelId,
        countryId: searchHistory.countryId,
        locationId: searchHistory.locationId,
      );
}

enum OtaRecommendationViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
