class QueriesCarRentalfavourite {
  static String getCarRentalFavouritesData(
    String type,
    int offset,
    int limit,
  ) {
    return '''
        query {
	getCarRentalFavorites(
		getFavoritesInput: {
			serviceName: "$type",
			offset: $offset,
			limit: $limit
		}
	) {
		data {
			favorites {
        serviceId
				supplierId
				name
				image
				location
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
			header
			description
		}
	}
}
''';
  }

  static String unFavouriteCarRental(
      String serviceName, String carId, String supplierId) {
    return '''
    mutation {
      deleteFavorite(
        deleteFavoriteRequest: { 
          serviceName: "$serviceName",
          carDetail: {
            serviceId: "$carId",
            supplierId: "$supplierId"
          }
        }
        ) {
        status {
          code
          header
        }
      }
    }
  ''';
  }
}
