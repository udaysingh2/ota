import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_all_favourite.dart';
import 'package:ota/domain/favourites/models/favourites_all_model_domain.dart';

abstract class FavouriteAllRemoteDataSource {
  /// Call API to get the Favourites Screen details.
  ///
  /// [Either<Failure, FavouritesResultModel>] to handle the Failure or result data.
  Future<FavouritesAllModelDomain> getAllFavouritesData(
      String type, int offset, int limit);
}

/// FavouritesRemoteDataSourceImpl will contain the FavouritesRemoteDataSource implementation.
class FavouritesAllRemoteDataSourceImpl
    implements FavouriteAllRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  FavouritesAllRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  Future<FavouritesAllModelDomain> getAllFavouritesData(
      String type, int offset, int limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesAllfavourite.getAllFavouritesData(type, offset, limit),
        queryName: QueryNames.shared.getFavorites);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavouritesAllModelDomain.fromMap(result.data!);
    }
  }
}
