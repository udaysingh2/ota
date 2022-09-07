import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_favourite_service.dart';
import 'package:ota/domain/favourites/models/favourites_add_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_check_service_domain.dart';
import 'package:ota/domain/favourites/models/favourites_remove_service_domain.dart';
import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_rental_favourite.dart';
import 'package:ota/core_pack/graphql/queries/queries_favourites.dart';
import '../models/unfavourite_model_domain.dart';

/// Interface for Favourites Data remote data source.
abstract class FavouritesServiceRemoteDataSource {
  /// Call API to check Favourite service status.
  Future<FavouriteCheckServiceDomain> checkFavorite(
      {required String serviceName, required String serviceId});

  /// Call API to remove Favourite service.
  Future<FavouriteRemoveServiceDomain> removeFavorite(
      {required String serviceName, required String serviceId});

  /// Call API to add Favourite service.
  Future<FavouriteAddServiceDomain> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel});

  /// Call API to remove Favourites CarRental.
  Future<UnFavouriteModelDomain> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId});

  /// Call API to remove Favourites Hotel.
  Future<UnFavouriteModelDomain> unfavouritesHotel({
    required String serviceName,
    required String hotelId,
  });

  /// Call API to remove Favourites Tour.
  Future<UnFavouriteModelDomain> unfavouritesTour({
    required String serviceName,
    required String serviceId,
  });
}

/// FavouritesRemoteDataSourceImpl will contain the FavouritesRemoteDataSource implementation.
class FavouritesServiceRemoteDataSourceImpl
    implements FavouritesServiceRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  FavouritesServiceRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  ///Call API to check Favourite service status.
  @override
  Future<FavouriteCheckServiceDomain> checkFavorite(
      {required String serviceName, required String serviceId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.checkFavorite,
        query: QueriesFavouriteService.getCheckFavouriteData(
            serviceName: serviceName, serviceId: serviceId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavouriteCheckServiceDomain.fromMap(result.data!);
    }
  }

  /// Call API to remove Favourite service.
  @override
  Future<FavouriteRemoveServiceDomain> removeFavorite(
      {required String serviceName, required String serviceId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.removeFavorite,
        query: QueriesFavouriteService.getRemoveFavouriteData(
            serviceName: serviceName, serviceId: serviceId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavouriteRemoveServiceDomain.fromMap(result.data!);
    }
  }

  /// Call API to remove Favourite service.
  @override
  Future<FavouriteAddServiceDomain> markFavorite(
      {required OtaFavoritesArgumentDomainModel favoriteArgumentModel}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.markFavorite,
        query: QueriesFavouriteService.getMarkFavouriteData(
            favoriteArgumentModel));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavouriteAddServiceDomain.fromMap(result.data!);
    }
  }

  /// Call API to remove Favourites All.
  @override
  Future<UnFavouriteModelDomain> unFavouriteCarRental(
      {required String serviceName,
      required String carId,
      required String supplierId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarRentalfavourite.unFavouriteCarRental(
            serviceName, carId, supplierId),
        queryName: QueryNames.shared.deleteFavorite);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return UnFavouriteModelDomain.fromMap(result.data!["deleteFavorite"]);
    }
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesHotel(
      {required String serviceName, required String hotelId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesFavourites.unfavouritesHotel(serviceName, hotelId),
        queryName: QueryNames.shared.deleteFavorite);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return UnFavouriteModelDomain.fromMap(result.data!["deleteFavorite"]);
    }
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesTour(
      {required String serviceName, required String serviceId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesFavourites.removeFavorite(serviceName, serviceId),
        queryName: QueryNames.shared.deleteFavorite);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return UnFavouriteModelDomain.fromMap(result.data!["removeFavorite"]);
    }
  }
}
