enum SearchServiceTypeAutomation { hotel, ota }

extension SearchServiceTypeExtensionAutomation on SearchServiceTypeAutomation {
  String get value {
    return this.toString().split('.').last.toUpperCase();
  }
}
