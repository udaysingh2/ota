import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/modules/search/hotel/helpers/search_helper.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';

/// This model is used for OTA Search Suggestions
class OtaSuggestionViewModel {
  List<OtaSuggestionModel> suggestionList;
  OtaSuggestionViewModelState suggestionState;

  OtaSuggestionViewModel({
    required this.suggestionList,
    this.suggestionState = OtaSuggestionViewModelState.none,
  });
}

enum OtaSuggestionViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}

class OtaSuggestionModel {
  String id;
  String name;
  String? hotelId;
  String? cityId;
  String? locationId;
  String? countryId;
  SearchSuggestionType searchSuggestionType;

  OtaSuggestionModel({
    required this.id,
    required this.name,
    required this.hotelId,
    required this.cityId,
    required this.countryId,
    required this.locationId,
    this.searchSuggestionType = SearchSuggestionType.hotel,
  });

  factory OtaSuggestionModel.fromSuggestion({
    City? cityLocationModel,
  }) {
    return SearchHelper.getSuggestionViewModel(
      SearchServiceType.ota,
      cityLocationModel: cityLocationModel,
    );
  }
}
