class QueriesAllfavourite {
  static String getAllFavouritesData(
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
