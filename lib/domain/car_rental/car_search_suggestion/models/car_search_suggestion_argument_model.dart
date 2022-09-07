class CarSearchSuggestionArgumentModelDomain {
  String searchCondition;
  String serviceType;
  List<String> searchType;
  int limit;

  CarSearchSuggestionArgumentModelDomain({
    required this.searchCondition,
    required this.serviceType,
    required this.searchType,
    required this.limit,
  });

  factory CarSearchSuggestionArgumentModelDomain.from(
      {required String searchCondition,
      required String serviceType,
      required List<String> searchType,
      required int limit}) {
    return CarSearchSuggestionArgumentModelDomain(
      searchCondition: searchCondition,
      serviceType: serviceType,
      searchType: searchType,
      limit: limit,
    );
  }
}

extension StringQuote on String {
  String addQuote() {
    return '"${this}"';
  }
}
