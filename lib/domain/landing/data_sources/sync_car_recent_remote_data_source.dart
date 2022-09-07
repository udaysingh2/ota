import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/querie_car_landing_sync_recent_search.dart';
import 'package:ota/domain/landing/models/sync_car_recent_search_model.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

abstract class SyncCarRecentRemoteDataSource {
  Future<SyncCarRecentSearchDomainModel> syncRecentSearchData(
      List<CarRecentSearchData> data,
      String userId,
      String searchKey,
      bool searchAvailableApi,
      bool includeDriver);
}

class RecentSearchRemoteDataSourceImpl
    implements SyncCarRecentRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  RecentSearchRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<SyncCarRecentSearchDomainModel> syncRecentSearchData(
      List<CarRecentSearchData> data,
      String userId,
      String searchKey,
      bool searchAvailableApi,
      bool includeDriver) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        queryName: QueryNames.shared.saveGuestRecentSearchPlaylistHistory,
        query: QueriesCarLandingSyncRecentSearch.syncRecentSearchData(
            data, userId, searchKey, searchAvailableApi, includeDriver));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SyncCarRecentSearchDomainModel.fromMap(
          result.data!["saveGuestRecentSearchPlaylistHistory"]);
    }
  }
}
