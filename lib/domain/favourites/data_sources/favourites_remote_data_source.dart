import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_favourites.dart';
import 'package:ota/domain/favourites/models/favourites_model_domain.dart';
import 'package:ota/domain/favourites/models/favourites_result_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';

/// Interface for Favourites Data remote data source.
abstract class FavouritesRemoteDataSource {
  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<FavouritesResultModelDomain> getFavouritesData(
      String type, int offset, int limit);

  Future<FavoritesModelDomain> getFavourites(
      String type, int offset, int limit);

  /// Call API to remove Favourites Hotel.
  Future<DeleteFavoriteModelDomain> unfavouritesHotel({
    required String type,
    required String hotelId,
  });
}

/// FavouritesRemoteDataSourceImpl will contain the FavouritesRemoteDataSource implementation.
class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  FavouritesRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  @override
  Future<FavouritesResultModelDomain> getFavouritesData(
      String type, int offset, int limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getAllFavorites,
        query: QueriesFavourites.getFavouritesData(type, offset, limit));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavouritesResultModelDomain.fromMap(result.data!);
    }
  }

  /// Call API to remove Favourites Hotel.
  @override
  Future<DeleteFavoriteModelDomain> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.deleteFavorite,
        query: QueriesFavourites.unfavouritesHotel(type, hotelId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return DeleteFavoriteModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<FavoritesModelDomain> getFavourites(
      String type, int offset, int limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getFavourites,
        query: QueriesFavourites.getFavorite(type, offset, limit));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavoritesModelDomain.fromMap(result.data!);
    }
  }
}
