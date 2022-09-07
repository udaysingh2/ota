import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/query_tour_save_search_history.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_model_domain.dart';

/// Interface for Save Search History remote data source.
abstract class TourSaveSearchHistoryRemoteDataSource {
  /// Call API to save the Search History.
  ///
  /// [Either<Failure, TourSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  Future<TourSaveSearchHistoryModelDomain> saveTourSearchHistoryData(
      TourSaveSearchHistoryArgumentDomain argument);
}

/// TourSaveSearchHistoryRemoteDataSourceImpl will contain the TourSaveSearchHistoryRemoteDataSource implementation.
class TourSaveSearchHistoryRemoteDataSourceImpl
    implements TourSaveSearchHistoryRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourSaveSearchHistoryRemoteDataSourceImpl(
      {GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to save the Search History.
  ///
  /// [Either<Failure, TourSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  @override
  Future<TourSaveSearchHistoryModelDomain> saveTourSearchHistoryData(
      TourSaveSearchHistoryArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.saveTourSearchHistoryData,
        query: QueriesTourSaveSearchHistory.saveSearchHistoryData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourSaveSearchHistoryModelDomain.fromMap(result.data!);
    }
  }
}
