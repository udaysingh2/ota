import 'package:ota/domain/search/models/search_service_type.dart';

class SuggestionDataArgumentAutomation {
  final String searchText;
  final SearchServiceType searchServiceType;
  final int offset;
  final int limit;

  SuggestionDataArgumentAutomation({
    required this.searchText,
    required this.searchServiceType,
    required this.offset,
    required this.limit,
  });

  factory SuggestionDataArgumentAutomation.fromHotelSuggestion(
      String searchText, int offset, int limit) {
    return SuggestionDataArgumentAutomation(
      searchText: searchText,
      searchServiceType: SearchServiceType.hotel,
      offset: offset,
      limit: limit,
    );
  }

  factory SuggestionDataArgumentAutomation.fromOtaSuggestion(
      String searchText, int offset, int limit) {
    return SuggestionDataArgumentAutomation(
      searchText: searchText,
      searchServiceType: SearchServiceType.ota,
      offset: offset,
      limit: limit,
    );
  }
}
