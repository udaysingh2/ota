class QueriesTourAttractions {
  static String getTourAttractionsData(String serviceType) {
    return '''
     query{
      getTourServiceSuggestions(serviceName: "$serviceType"){
        data{
        locationList
        {
          serviceTitle
          searchKey
          cityId
          countryId
          imageUrl
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
