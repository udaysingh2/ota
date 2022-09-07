import 'package:ota/domain/search/models/search_service_type.dart';

import '../models/search_service_type_automation.dart';
import '../models/search_suggestion_data_argument_model_automation.dart';

class QueriesSearchAutomation {
  static String getSearchSuggestionData(
      SuggestionDataArgumentAutomation suggestionArgument) {
    return '''
          mutation {
            getSearchSuggestion(
              searchInput: {
                searchCondition: "${suggestionArgument.searchText}"
                serviceType: "${suggestionArgument.searchServiceType.value}"
                offset: ${suggestionArgument.offset}
                limit: ${suggestionArgument.limit}
              }
            ) {
              data {
                suggestions {
                  hotelId
                  hotelName
                  cityId
                  cityName
                  countryId
                  countryName
                  locationId
                  locationName
                  level
                  searchid
                  filterName
                }
              }
              status {
                code
                description
                errors
              }
            }
          }
    ''';
  }

  static String getSearchRecommendationData(
      SearchServiceTypeAutomation searchServiceType) {
    return '''
          mutation {
            getSearchRecommendation(
              recommendationRequest: { serviceType: "${searchServiceType.value}" }
            ) {
              data {
                recommendationKey
                recommendations {
                  playlistId
                  serviceTitle
                  hotelId
                  cityId
                  countryId
                  imageUrl
                }
              }
              status {
                code
                header
                description
              }
            }
          }
      ''';
  }
}
