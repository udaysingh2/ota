import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_favourites.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';

/// Interface for Hotel detail Data remote data source.
abstract class HotelDetailRemoteDataSource {
  Future<HotelDetailModelDomain> getHotelDetail(
      HotelDetailDataArgument argument);

  Future<IsFavoritesDomain> checkFavouriteHotel({
    required String type,
    required String hotelId,
  });

  Future<DeleteFavoriteModelDomain> unfavouritesHotel({
    required String type,
    required String hotelId,
  });

  Future<AddFavoriteModelDomain> addFavouriteHotel({
    required AddFavoriteArgumentModelDomain favoriteArgumentModel,
  });
}

class HotelDetailRemoteDataSourceImpl implements HotelDetailRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelDetailRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<HotelDetailModelDomain> getHotelDetail(
      HotelDetailDataArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getHotelDetails,
        query: QueriesHotel.getHotelDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelDetailModelDomain.fromMap(result.data!);
    }
  }

  /// call APi to check Favourites Hotel
  @override
  Future<IsFavoritesDomain> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.checkFavorites,
        query: QueriesHotel.checkFavorites(type, hotelId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return IsFavoritesDomain.fromMap(result.data!);
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

  /// Call Api to add Favourites Hotel
  @override
  Future<AddFavoriteModelDomain> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.addFavorite,
        query: QueriesHotel.addFavourite(favoriteArgumentModel));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return AddFavoriteModelDomain.fromMap(result.data!);
    }
  }
}
