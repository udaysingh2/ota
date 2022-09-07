import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/querie_car_landing_recent_search.dart';
import 'package:ota/core_pack/graphql/queries/querie_clear_search.dart';

import '../models/clear_recent_search_domain_model.dart';
import '../models/landing_recent_search_domain_model.dart';

abstract class CarLandingRemoteDataSource {
  Future<LandingRecentSearchDomainModel> getRecentSearches(
      String serviceType, String dataSearchType);
  Future<ClearRecentSearchDomainModel> clearRecentSearch(
      String serviceType, String dataSearchType);
}

/// CarSearchResultRemoteDataSourceImpl will contain the CarSearchResultRemoteDataSource implementation.
class CarLandingRemoteDataSourceImpl implements CarLandingRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarLandingRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<LandingRecentSearchDomainModel> getRecentSearches(
      String serviceType, String dataSearchType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarLandingRecentSearch.getRecentSearchData(
            serviceType, dataSearchType),
        queryName: QueryNames.shared.getRecentSearches);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      LandingRecentSearchDomainModel landingRecentSearchDomainModel =
          LandingRecentSearchDomainModel.fromMap(
              result.data?["getCarRentalRecentSearches"]);
      return landingRecentSearchDomainModel;
    }
  }

  @override
  Future<ClearRecentSearchDomainModel> clearRecentSearch(
      String serviceType, String dataSearchType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query:
            QueryClearSearch.clearRecentSearchData(serviceType, dataSearchType),
        queryName: QueryNames.shared.clearRecentSearch);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return ClearRecentSearchDomainModel.fromMap(result.data!);
    }
  }
}
