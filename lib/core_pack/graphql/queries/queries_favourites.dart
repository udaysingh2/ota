class QueriesFavourites {
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
              promotionList {
                endDate
                startDate
                line2
                line1
                promotionCode
                promotionType
                productType
                productId
              }
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

  static String removeFavorite(
    String type,
    String id,
  ) {
    return '''
        mutation {
          removeFavorite(
            removeFavoriteRequest: { serviceName: "$type", id: "$id" }
          ) {
            status {
              code
              header
              description
            }
          }
        }
    ''';
  }

  static String getFavorite(
    String type,
    int offset,
    int limit,
  ) {
    return '''
 query {
          getFavorites(
            getFavoritesInput: { 
            serviceName: "$type", 
            limit: $limit, 
            offset: $offset 
            }
          ) {
            data {
              favorites {
                serviceId
                cityId
                countryId
                name
                image
                location
                category
                serviceName
         				supplierId
				        pickupLocationId
				        dropLocationId
				        pickupCounter
                returnCounter
                promotionList {
				        	endDate
				        	startDate
				        	line2
				        	line1
				        	promotionCode
				        	promotionType
				        	productType
				        	productId
				        }
              }
            }
            status {
              code
              description
              header
            }
          }
        }
    ''';
  }
}
