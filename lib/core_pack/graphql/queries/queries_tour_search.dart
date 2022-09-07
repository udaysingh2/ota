class QueriesTourSearch {
  static String getSearchHistoryData() {
    return '''
     query{
  getTourAndTicketRecentSearches(recentSearchRequest: { serviceType: "TOUR"}){
    data{
      searchHistory{
        serviceType
        keyword
        countryId
        cityId
        placeId
        locationName
      }
    }status{
      code
	  header
	  description
    }
  }
}
    ''';
  }
}
