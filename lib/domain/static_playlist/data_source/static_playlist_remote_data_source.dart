import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_static_playlist.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';

/// Interface for OtaStaticPlayListRemoteDataSource data source.
abstract class OtaStaticPlayListRemoteDataSource {
  /// Call API to get the Static playlist on landing screen.
  ///
  /// [staticPlaylistArgumentData] to get the Static playlist on landing screen.
  /// [Either<Failure, StaticPlayListModelDomain>] to handle the Failure or result data.
  Future<StaticPlayListModelDomain> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain staticPlaylistArgumentData);
}

/// OtaStaticPlayListRemoteDataSourceImpl will contain the OtaStaticPlayListRemoteDataSource implementation.
class OtaStaticPlayListRemoteDataSourceImpl
    implements OtaStaticPlayListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  OtaStaticPlayListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Static playlist on landing screen.
  ///
  /// [serviceDataArgument] to get the Static playlist on landing screen.
  /// [Either<Failure, StaticPlayListModelDomain>] to handle the Failure or result data.
  @override
  Future<StaticPlayListModelDomain> getOtaStaticPlaylist(
      StaticPlaylistArgumentDomain staticPlaylistArgumentData) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
      //This is mandatory for crashlytics provide the query name here
      queryName: QueryNames.shared.getOtaStaticPlaylist,
      query: QueriesOtaStaticPlaylistData.getOtaStaticPlayList(
          staticPlaylistArgumentData),
    );
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      StaticPlayListModelDomain staticPlaylist =
          StaticPlayListModelDomain.fromMap(result.data!);
      return staticPlaylist;
    }
  }
}
