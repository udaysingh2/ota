class QueriesFavouritesAutomation {
  static String getFavouritesData(
    String type,
    int offset,
    int limit,
  ) {
    return '''
    query {
      getAllFavorites (
        requestParms: { 
          serviceName: "$type",
          offset: $offset,
          limit: $limit
        }
      ) 
        {
          data {
            favorites {
              hotelId
              cityId
              countryId
              hotelName
              hotelImage
              location
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

  static String unfavouritesHotel(
    String type,
    String hotelId,
  ) {
    return '''
    mutation {
      deleteFavorite 
      (
        deleteFavoriteRequest: {
          serviceName: "$type",
          hotelId: "$hotelId" 
        }
      ) 
        {
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
