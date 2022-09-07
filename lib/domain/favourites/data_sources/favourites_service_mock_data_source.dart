import 'package:ota/domain/favourites/models/favourites_add_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_check_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_remove_service_domain.dart';
import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';

import 'favourites_service_remote_data_source.dart';

class FavouritesServiceMockDataSourceImpl
    implements FavouritesServiceRemoteDataSource {
  FavouritesServiceMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  static String removeHotelCarMockSuccess() {
    return _deleteFavoriteMock;
  }

  static String removeTourMockSuccess() {
    return _removeFavoriteMock;
  }

  static String removeFavoriteMockFailure() {
    return _removeFavoriteFailureMock;
  }

  /// Call API to check Favourite service status.
  @override
  Future<FavouriteCheckServiceDomain> checkFavorite(
      {required String serviceName, required String serviceId}) async {
    await Future.delayed(const Duration(seconds: 1));
    return FavouriteCheckServiceDomain.fromJson(_responseMock);
  }

  /// Call API to remove Favourite service.
  @override
  Future<FavouriteRemoveServiceDomain> removeFavorite(
      {required String serviceName, required String serviceId}) async {
    await Future.delayed(const Duration(seconds: 2));
    return FavouriteRemoveServiceDomain.fromJson(_removeFavoriteMock);
  }

  /// Call API to add Favourite service.
  @override
  Future<FavouriteAddServiceDomain> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel}) async {
    await Future.delayed(const Duration(seconds: 2));
    return FavouriteAddServiceDomain.fromJson(_markrFavoriteMock);
  }

  @override
  Future<UnFavouriteModelDomain> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId}) async {
    await Future.delayed(const Duration(seconds: 2));
    return UnFavouriteModelDomain.fromJson(_unFavouriteResponse);
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesHotel({
    required String serviceName,
    required String hotelId,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return UnFavouriteModelDomain.fromJson(_unFavouriteResponse);
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesTour({
    required String serviceName,
    required String serviceId,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return UnFavouriteModelDomain.fromJson(_unFavouriteResponse);
  }
}

var _unFavouriteResponse = """ { 
  "status": {
    "code": "1000", 
    "header": "Success",
    "description": "You have exceeded the maximum numbers of favorites added" 
  } 
}
""";

String _responseMock = '''
  {
        "isFavorite": {
            "data": {
                "isFavorite": true
            },
            "status": {
                "code": "1000",
                "header": "Success",
                "description": null
            }
        }

}
''';

var _markrFavoriteMock = """
{
    "markFavorite": {
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
}
""";

var _removeFavoriteMock = """
{
        "removeFavorite": {
            "status": {
                "code": "1000",
                "header": "Success",
                "description": null
            }
        }
}
""";
var _removeFavoriteFailureMock = """
{
        "deleteFavorite": {
            "status": {
                "code": "1899",
                "header": "Failure ",
                "description": null
            }
        }
}
""";

var _deleteFavoriteMock = """
{
        "deleteFavorite": {
            "status": {
                "code": "1000",
                "header": "Success",
                "description": null
            }
        }
}
""";
