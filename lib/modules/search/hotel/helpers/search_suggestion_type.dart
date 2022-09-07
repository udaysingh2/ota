enum SearchSuggestionType {
  hotel,
  cityLocation,
}

/// Level (1=City, 2=Hotel, 3=Location)
extension SearchSuggestionTypeExtension on SearchSuggestionType {
  int get value {
    switch (this) {
      case SearchSuggestionType.cityLocation:
        return 1;
      case SearchSuggestionType.hotel:
        return 2;
    }
  }
}
