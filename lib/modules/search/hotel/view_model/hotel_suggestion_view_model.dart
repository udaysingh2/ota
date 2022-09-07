import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/modules/search/hotel/helpers/search_helper.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';

/// This model is used for Hotel Search Suggestions
class HotelSuggestionViewModel {
  List<HotelSuggestionModel> suggestionList;
  HotelSuggestionViewModelState suggestionState;

  HotelSuggestionViewModel({
    required this.suggestionList,
    this.suggestionState = HotelSuggestionViewModelState.none,
  });
}

enum HotelSuggestionViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}

class HotelSuggestionModel {
  String id;
  String name;
  String? hotelId;
  String? cityId;
  String? locationId;
  String? countryId;
  SearchSuggestionType searchSuggestionType;

  HotelSuggestionModel({
    required this.id,
    required this.name,
    required this.hotelId,
    required this.cityId,
    required this.countryId,
    required this.locationId,
    this.searchSuggestionType = SearchSuggestionType.hotel,
  });

  factory HotelSuggestionModel.fromSuggestion(
      {City? cityLocationModel, Hotel? hotelModel}) {
    return SearchHelper.getSuggestionViewModel(
      SearchServiceType.hotel,
      cityLocationModel: cityLocationModel,
      hotelModel: hotelModel,
    );
  }
}
