import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel_static_playlist.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';

/// Interface for Playlist Data remote data source.
abstract class HotelStaticPlayListRemoteDataSource {
  /// Call API to get the Playlist Screen details.

  Future<HotelStaticPlayListModelDomain> getHotelStaticPlayListData(
      HotelStaticPlayListArgumentModelDomain argument);
}

/// HotelStaticPlayListRemoteDataSourceImpl will contain the HotelStaticPlayListRemoteDataSource implementation.
class HotelStaticPlayListRemoteDataSourceImpl
    implements HotelStaticPlayListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelStaticPlayListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<HotelStaticPlayListModelDomain> getHotelStaticPlayListData(
      HotelStaticPlayListArgumentModelDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getPlaylists,
        query: QueriesHotelStaticPlayList.getHotelStaticPlayList(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelStaticPlayListModelDomain.fromMap(result.data!);
    }
  }
}
