import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_argument_domain.dart';

class QueriesTourSearchSuggestions {
  static String getSearchSuggestionsData(
      TourSearchSuggestionsArgumentDomain argument) {
    var value = argument.searchType.map((result) => result.addQuote()).toList();
    return '''
query 
   {
      getDataScienceAutoCompleteSearch(
        autocompleteSearchRequest: {
          searchCondition: "${argument.searchCondition}"
          serviceType: "${argument.serviceType}"
          limit: ${argument.limit}
          searchType: $value
        }
      ) {
        status{
          code
          header
          description
        }
        data {
          suggestions {
          tour{
          keyword
          countryId
          cityId
          id
          locationName
        } 
        ticket{
          keyword
          countryId
          cityId
          id
          locationName
        } 
        cityLocation{
          keyword
          countryId
          cityId
          id
          locationName
        } 
          }
        }
      }
  }
    ''';
  }
}
