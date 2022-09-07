import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_playlist.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';

/// Interface for Room detail Data remote data source.
/// Change the argument model
abstract class HotelLandingDynamicDataSource {
  Future<HotelLandingDynamicSingleData> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument);
}

class HotelLandingDynamicDataSourceImpl
    implements HotelLandingDynamicDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelLandingDynamicDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<HotelLandingDynamicSingleData> getPlaylist(
      HotelLandingDynamicSingleDataArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getPlaylists,
        query: QueriesPlayList.getLandingDynamicPlayListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelLandingDynamicSingleData.fromMap(result.data!);
    }
  }
}
