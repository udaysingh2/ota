enum SearchServiceType { hotel, ota }

extension SearchServiceTypeExtension on SearchServiceType {
  String get value {
    return toString().split('.').last.toUpperCase();
  }
}
