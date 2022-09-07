import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_recent_playlist.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_argument_model.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';

/// Interface for Hotel detail Data remote data source.
abstract class TourRecentPlaylistRemoteDataSource {
  Future<TourRecentPlaylistModelDomain> getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument);
}

class TourRecentPlaylistRemoteDataSourceImpl
    implements TourRecentPlaylistRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourRecentPlaylistRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TourRecentPlaylistModelDomain> getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourRecentPlaylist,
        query: QueriesTourRecentPlaylist.getTourRecentPlaylist(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourRecentPlaylistModelDomain.fromMap(result.data!);
    }
  }
}
