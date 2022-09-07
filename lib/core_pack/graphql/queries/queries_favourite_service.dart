import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';

class QueriesFavouriteService {
  static String getCheckFavouriteData({
    required String serviceName,
    required String serviceId,
  }) {
    return '''
        query{
          isFavorite(
          serviceName: "$serviceName", 
          id: "$serviceId"
          ){
            data {
              isFavorite
            }
            status{
              code
              header
              description
            }
          }
        }
       ''';
  }

  static String getRemoveFavouriteData({
    required String serviceName,
    required String serviceId,
  }) {
    return '''
      mutation {
        removeFavorite(
          removeFavoriteRequest: { 
           serviceName: "$serviceName", 
           id: "$serviceId"
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

  static String getMarkFavouriteData(
    OtaFavoritesArgumentDomainModel argumentModel,
  ) {
    return '''
      mutation {
        markFavorite(
          addFavoriteRequest: ${argumentModel.toMap()}
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
