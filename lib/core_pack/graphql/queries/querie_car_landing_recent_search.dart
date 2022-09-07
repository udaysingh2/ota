class QueriesCarLandingRecentSearch {
  static String getRecentSearchData(String serviceType, String dataSearchType) {
    return '''  
   query {
  getCarRentalRecentSearches(
    recentSearchRequest: {
      serviceType: "$serviceType"
      dataSearchType:"$dataSearchType"
    }
  ) {
    data {
      searchHistory {
        carRental {
          carRecentSearchList {
            age
            pickupLocationId
            returnLocationId
            pickupLocationName
            returnLocationName
            pickupTime
            returnTime
            pickupDate
            returnDate
          }
        }
      }
    }
    status {
      code
      header
    }
  }
}
    ''';
  }
}
