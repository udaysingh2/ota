class TourSearchSuggestionsArgumentDomain {
  String searchCondition;
  String serviceType;
  List<String> searchType;
  int limit;

  TourSearchSuggestionsArgumentDomain({
    required this.searchCondition,
    required this.serviceType,
    required this.searchType,
    required this.limit,
  });

  factory TourSearchSuggestionsArgumentDomain.from(
      {required String searchCondition,
      required String serviceType,
      required List<String> searchType,
      required int limit}) {
    return TourSearchSuggestionsArgumentDomain(
      searchCondition: searchCondition,
      serviceType: serviceType,
      searchType: searchType,
      limit: limit,
    );
  }
}
