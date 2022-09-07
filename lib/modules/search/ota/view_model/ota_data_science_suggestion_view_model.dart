
class OtaDataScienceSuggestionViewModel {
  List<SuggestionModel> suggestionList;
  OtaDataScienceSuggestionViewModelState suggestionState;

  OtaDataScienceSuggestionViewModel({
    required this.suggestionList,
    this.suggestionState = OtaDataScienceSuggestionViewModelState.none,
  });
}

enum OtaDataScienceSuggestionViewModelState {
  none,
  loading,
  success,
  failure,
}

class SuggestionModel {
  String keyword;
  String id;
  String? locationName;
  String? cityId;
  String? countryId;
  String? cityName;

  SuggestionModel({
    required this.id,
    required this.keyword,
    required this.cityId,
    required this.countryId,
    this.locationName,
    this.cityName,
  });
}

class LocationViewModel {
  String keyword;
  String id;
  String? locationName;
  String? cityId;
  String? countryId;

  LocationViewModel({
    required this.id,
    required this.keyword,
    required this.cityId,
    required this.countryId,
    required this.locationName,
  });
}

class CityViewModel {
  String keyword;
  String? cityName;
  String? cityId;
  String? countryId;

  CityViewModel({
    required this.cityId,
    required this.countryId,
    required this.keyword,
    required this.cityName
  });
}