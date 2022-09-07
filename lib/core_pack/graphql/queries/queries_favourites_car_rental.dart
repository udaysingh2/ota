import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';

class QueriesFavouritesCarRental {
  static String unfavouriteCar(
      String id, String supplierId, String serviceName) {
    return '''
    mutation {
  deleteFavorite(
    deleteFavoriteRequest: { 
        serviceName: "$serviceName",
        carDetail: {
          serviceId: "$id",
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

  static String addFavourite(
      AddFavoriteArgumentModelDomain favoriteArgumentModel,
      String serviceName) {
    return '''
    mutation {
  addFavorite(
    addFavoriteRequest: {
    serviceName: "$serviceName",
    carDetail: {
        serviceId: "${favoriteArgumentModel.id}",
        supplierId: "${favoriteArgumentModel.supplierId}",
        name: "${favoriteArgumentModel.name}",
        location: "${favoriteArgumentModel.location}",
        image: "${favoriteArgumentModel.image}",
        pickupLocationId: "${favoriteArgumentModel.pickupLocationId}",
        dropLocationId: "${favoriteArgumentModel.dropLocationId}",
        pickupDate: "${favoriteArgumentModel.pickupDate}",
        dropDate: "${favoriteArgumentModel.dropDate}",
        rentalType: "${favoriteArgumentModel.rentalType}",
        age:${favoriteArgumentModel.age},
        pickupCounter:"${favoriteArgumentModel.pickupCounter}",
        returnCounter: "${favoriteArgumentModel.returnCounter}"
    }
}
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

  static String checkFavourite(
      String carId, String supplierId, String serviceName) {
    return '''
    query{
  checkCarFavorites(serviceName: "$serviceName", carId: "$carId", supplierId:"$supplierId"){
    data {
      isFavorite
    }
    status{
      code
      header
    }
  }
}
    ''';
  }
}
