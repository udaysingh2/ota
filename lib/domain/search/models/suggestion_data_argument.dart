const _kHotelType = "HOTEL";
const _kOtaType = "OTA";

class SuggestionDataArgument {
  final String searchText;
  final String searchServiceType;
  final int limit;
  final String enabledServices;
  SuggestionDataArgument({
    required this.searchText,
    required this.searchServiceType,
    required this.limit,
    required this.enabledServices,
  });

  factory SuggestionDataArgument.fromHotelSuggestion(
      String searchText, int limit, String enabledServices) {
    return SuggestionDataArgument(
      searchText: searchText,
      searchServiceType: _kHotelType,
      limit: limit,
      enabledServices: enabledServices,
    );
  }

  factory SuggestionDataArgument.fromOtaSuggestion(
      String searchText, int limit, String enabledServices) {
    return SuggestionDataArgument(
      searchText: searchText,
      searchServiceType: _kOtaType,
      limit: limit,
      enabledServices: enabledServices,
    );
  }
}
