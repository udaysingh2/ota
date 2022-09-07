import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_search.dart';
import 'package:ota/domain/tours/search/model/tour_search_history_model_domain.dart';

/// Interface for Search Data remote data source.
abstract class TourSearchRemoteDataSource {
  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [Either<Failure, TourAndTicketRecentSearchesModel>] to handle the Failure or result data.
  Future<TourSearchHistoryModelDomain> getTourSearchHistoryData();
}

/// SearchRemoteDataSourceImpl will contain the TourSearchRemoteDataSource implementation.
class TourSearchRemoteDataSourceImpl implements TourSearchRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourSearchRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [Either<Failure, TourAndTicketRecentSearchesModel>] to handle the Failure or result data.
  @override
  Future<TourSearchHistoryModelDomain> getTourSearchHistoryData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourSearchHistoryData,
        query: QueriesTourSearch.getSearchHistoryData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourSearchHistoryModelDomain.fromMap(result.data!);
    }
  }
}
