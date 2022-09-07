import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_ticket_playlist.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';

abstract class TourTicketPlaylistRemoteDataSource {
  Future<TourTicketPlaylistModelDomain> getTourTicketPlaylistData(
      TourTicketPlaylistArgumentDomain argument);
}

class TourTicketPlaylistRemoteDataSourceImpl
    implements TourTicketPlaylistRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourTicketPlaylistRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TourTicketPlaylistModelDomain> getTourTicketPlaylistData(
      argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourTicketPlaylistData,
        query: QueriesTourTicketPlaylist.getTourTicketPlaylistData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourTicketPlaylistModelDomain.fromMap(result.data!);
    }
  }
}
