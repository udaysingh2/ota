class QueriesCarSearchHistory {
  static String getSearchHistoryData() {
    return '''
       query {
  getCarRentalRecentSearches(
    recentSearchRequest: {
      serviceType: "CARRENTAL"
      dataSearchType: "AUTOCOMPLETE"
    }
  ) {
    data {
      searchHistory {
        carRental {
          carRecentSearchList {
            cityId
            countryId
            locationId
            createdDate
            updatedDate
            searchKey
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
