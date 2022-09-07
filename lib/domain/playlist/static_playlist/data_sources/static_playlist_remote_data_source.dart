import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_static_playlist.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';

/// Interface for Playlist Data remote data source.
abstract class StaticPlayListRemoteDataSource {
  /// Call API to get the Playlist Screen details.
  ///
  /// [hotelId] to get the Playlist Data for users.
  /// [Either<Failure, StaticPlaylistModel>] to handle the Failure or result data.
  Future<StaticPlaylistModelDomain> getStaticPlayListData();
}

/// StaticPlayListRemoteDataSourceImpl will contain the StaticPlayListRemoteDataSource implementation.
class StaticPlayListRemoteDataSourceImpl
    implements StaticPlayListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  StaticPlayListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Playlist Screen details.
  ///
  /// [hotelId] to get the Playlist Data for users.
  /// [Either<Failure, StaticPlaylistModel>] to handle the Failure or result data.
  @override
  Future<StaticPlaylistModelDomain> getStaticPlayListData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getStaticPlaylists,
        query: QueriesStaticPlayList.getStaticPlayListData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return StaticPlaylistModelDomain.fromMap(result.data!);
    }
  }
}
