import 'package:ota/domain/tours/search/model/tour_search_history_model_domain.dart';

class TourSearchHistoryViewModel {
  List<TourSearchHistoryModel> searchHistoryList;
  TourSearchHistoryViewModelState recommendationState;

  TourSearchHistoryViewModel({
    required this.searchHistoryList,
    this.recommendationState = TourSearchHistoryViewModelState.none,
  });
}

class TourSearchHistoryModel {
  TourSearchHistoryModel({
    this.serviceType,
    this.keyword,
    this.countryId,
    this.cityId,
    this.placeId,
    this.locationName,
  });

  final String? serviceType;
  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? placeId;
  final String? locationName;

  factory TourSearchHistoryModel.mapFromModel(SearchHistory searchHistory) =>
      TourSearchHistoryModel(
        serviceType: searchHistory.serviceType,
        keyword: searchHistory.keyword,
        countryId: searchHistory.countryId,
        cityId: searchHistory.cityId,
        placeId: searchHistory.placeId,
        locationName: searchHistory.locationName,
      );
}

enum TourSearchHistoryViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
