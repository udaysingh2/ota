import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';

class CarSearchHistoryViewModel {
  List<CarRentalSearchHistoryModel> searchHistoryList;

  CarSearchHistoryViewModelState recommendationState;

  CarSearchHistoryViewModel({
    required this.searchHistoryList,
    this.recommendationState = CarSearchHistoryViewModelState.none,
  });
}

class CarRentalSearchHistoryModel {
  CarRentalSearchHistoryModel({
    this.createdDate,
    this.keyword,
    this.countryId,
    this.cityId,
    this.placeId,
  });

  final String? createdDate;
  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? placeId;

  factory CarRentalSearchHistoryModel.mapFromModel(
      CarRecentSearchList searchHistory) =>
      CarRentalSearchHistoryModel(
        createdDate: searchHistory.createdDate,
        keyword: searchHistory.searchKey,
        countryId: searchHistory.countryId,
        cityId: searchHistory.cityId,
        placeId: searchHistory.locationId,
      );
}

enum CarSearchHistoryViewModelState {
  none,
  loading,
  success,
  failure,
}
