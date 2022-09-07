import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';

const _kHotelType = "HOTEL";
const String _kTourKey = "tour_key";

class QueriesSearch {
  static String getSearchAutoCompleteSuggestionData(
      SuggestionDataArgument suggestionArgument) {
    if (suggestionArgument.searchServiceType == _kHotelType) {
      return '''
          query Query {
            getDataScienceAutoCompleteSearch(
              autocompleteSearchRequest: {
                searchCondition: "${suggestionArgument.searchText}"
                serviceType: "${suggestionArgument.searchServiceType}"
                limit: ${suggestionArgument.limit}
              }
            ) {
              data {
                suggestions {
                  city {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  cityLocation {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  location {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  hotel {
                    cityId
                    displayText
                    hotelId
                    countryId
                    hotelName
                    locationId
                  }
                }
              }
              status {
                code
                header
                description
                errors
              }
            }
          }
    ''';
    } else if (suggestionArgument.enabledServices.contains(_kTourKey)) {
      return '''
          query Query {
            getDataScienceAutoCompleteSearch(
              autocompleteSearchRequest: {
                searchCondition: "${suggestionArgument.searchText}"
                serviceType: "${suggestionArgument.searchServiceType}"
                limit: ${suggestionArgument.limit}
              }
            ) {
              data {
                suggestions {
                  tour {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  ticket {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  city {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  cityLocation {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  location {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  hotel {
                    cityId
                    displayText
                    hotelId
                    countryId
                    hotelName
                    locationId
                  }
                }
              }
              status {
                code
                header
                description
                errors
              }
            }
          }
    ''';
    }
    return '''
          query Query {
            getDataScienceAutoCompleteSearch(
              autocompleteSearchRequest: {
                searchCondition: "${suggestionArgument.searchText}"
                serviceType: "${suggestionArgument.searchServiceType}"
                limit: ${suggestionArgument.limit}
              }
            ) {
              data {
                suggestions {
                  city {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  cityLocation {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  location {
                    keyword
                    id
                    locationName
                    cityId
                    cityName
                    countryId
                  }
                  hotel {
                    cityId
                    displayText
                    hotelId
                    countryId
                    hotelName
                    locationId
                  }
                }
              }
              status {
                code
                header
                description
                errors
              }
            }
          }
    ''';
  }

  static String getSearchRecommendationData(
      SearchServiceType searchServiceType) {
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
        searchHistory {
          keyword
          checkInDate
          checkOutDate
          hotelId
          cityId
          countryId
          locationId
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

  static String getHotelSearchRecommendationData(
      HotelRecommendationArgDomain recommendationArgument) {
    return '''
            mutation GetHotelSearchRecommendation {
      getHotelSearchRecommendation(
        recommendationRequest: {
          serviceType: "${recommendationArgument.searchServiceType.value}"
          latitude: ${recommendationArgument.latitude}
          longitude: ${recommendationArgument.longitude}
          offset:${recommendationArgument.offset},
          limit:${recommendationArgument.limit}
        }
      ){
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
        searchHistory {
          keyword
          checkInDate
          checkOutDate
          hotelId
          cityId
          countryId
          locationId
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
