class QueriesRecommendedLocation {
  ///Change the argument model
  static String getRecommendedLocationData(String serviceType) {
    return '''
      query {
        getRecommendedLocation(serviceType: "$serviceType") {
          data {
            locationList {
              playlistId
              searchKey
              serviceTitle
              hotelId
              imageUrl
              countryId
              cityId
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
