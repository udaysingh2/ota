import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_playlist.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/playlist/models/playlist_result_model_domain.dart';

/// Interface for Playlist Data remote data source.
abstract class PlayListRemoteDataSource {
  /// Call API to get the Playlist Screen details.
  ///
  /// [hotelId] to get the Playlist Data for users.
  /// [Either<Failure, PlaylistResultModel>] to handle the Failure or result data.
  Future<PlaylistResultModelDomain> getPlayListData(
      PlayListDataArgument argument);
}

/// PlayListRemoteDataSourceImpl will contain the PlayListRemoteDataSource implementation.
class PlayListRemoteDataSourceImpl implements PlayListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PlayListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  /// [Either<Failure, PlaylistResultModel>] to handle the Failure or result data.
  @override
  Future<PlaylistResultModelDomain> getPlayListData(
      PlayListDataArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getPlaylists,
        query: QueriesPlayList.getPlayListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PlaylistResultModelDomain.fromMap(result.data!);
    }
  }
}
