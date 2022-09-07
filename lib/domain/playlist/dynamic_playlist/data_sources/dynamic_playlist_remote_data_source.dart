import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_dynamic_playlist.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';

/// Interface for Playlist Data remote data source.
abstract class DynamicPlayListRemoteDataSource {
  /// Call API to get the Playlist Screen details.
  ///
  /// [hotelId] to get the Playlist Data for users.
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<DynamicPlaylistModel> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument);
}

/// DynamicPlayListRemoteDataSourceImpl will contain the DynamicPlayListRemoteDataSource implementation.
class DynamicPlayListRemoteDataSourceImpl
    implements DynamicPlayListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  DynamicPlayListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  @override
  Future<DynamicPlaylistModel> getDynamicPlayListData(
      DynamicPlayListDataArgumentModelDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getDynamicPlaylists,
        query: QueriesDynamicPlayList.getDynamicPlayListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return DynamicPlaylistModel.fromMap(result.data!);
    }
  }
}
