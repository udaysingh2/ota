import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_save_search_history.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';

/// Interface for Save Search History remote data source.
abstract class CarSaveSearchHistoryRemoteDataSource {
  /// Call API to save the Search History.
  ///
  /// [Either<Failure, CarSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  Future<CarSaveSearchHistoryModelDomain> saveCarSearchHistoryData(
      CarSaveSearchHistoryArgumentDomain argument);
}

/// CarSaveSearchHistoryRemoteDataSourceImpl will contain the CarSaveSearchHistoryRemoteDataSource implementation.
class CarSaveSearchHistoryRemoteDataSourceImpl
    implements CarSaveSearchHistoryRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarSaveSearchHistoryRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  /// [Either<Failure, CarSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  @override
  Future<CarSaveSearchHistoryModelDomain> saveCarSearchHistoryData(
      CarSaveSearchHistoryArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarSaveSearchHistory.saveSearchHistoryData(argument),
        queryName: QueryNames.shared.saveRecentCarRentalSearchHistory);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarSaveSearchHistoryModelDomain.fromMap(result.data!);
    }
  }
}
