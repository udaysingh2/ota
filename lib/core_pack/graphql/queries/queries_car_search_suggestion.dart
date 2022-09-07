import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';

class QueriesCarSearchSuggestion {
  static String getCarSearchSuggestionData(
      CarSearchSuggestionArgumentModelDomain argument) {
    var value = argument.searchType.map((result) => result.addQuote()).toList();
    return '''
 query { getDataScienceAutoCompleteSearch(
  autocompleteSearchRequest: {
          searchCondition: "${argument.searchCondition}"
          serviceType: "${argument.serviceType}"
          limit: ${argument.limit}
          searchType: $value
  }) {
    status {
      code
      header
    }
    data {
      suggestions {
        city {
          keyword
          id
          cityName
          cityId
          countryId
        }
        cityLocation {
          keyword
          id
          locationName
          cityId
          countryId
        }
        location {
          keyword
          id
          cityId
          countryId
          locationName
        }
      }
    }
  }
}
    ''';
  }
}
