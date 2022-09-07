import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../../../../core_pack/graphql/queries/queries_hotel_dynamic_playlist.dart';
import '../models/hotel_dynamic_playlist_argument_model.dart';
import '../models/hotel_dynamic_playlist_model_domain.dart';

/// Interface for Playlist Data remote data source.
abstract class HotelDynamicPlayListRemoteDataSource {
  /// Call API to get the Playlist Screen details.

  Future<HotelDynamicPlayListModelDomainData> getHotelDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain argument);
}

/// HotelDynamicPlayListRemoteDataSourceImpl will contain the HotelDynamicPlayListRemoteDataSource implementation.
class HotelDynamicPlayListRemoteDataSourceImpl
    implements HotelDynamicPlayListRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  HotelDynamicPlayListRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<HotelDynamicPlayListModelDomainData> getHotelDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getRecentViewPlaylist,
        query: QueriesHotelDynamicPlayList.getDynamicPlayListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelDynamicPlayListModelDomainData.fromMap(result.data!);
    }
  }
}
