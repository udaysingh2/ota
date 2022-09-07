import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_search_history.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';

abstract class CarSearchHistoryRemoteDataSource {
  Future<CarSearchHistoryModelDomainData> getCarSearchHistoryData();
}

class CarSearchHistoryRemoteDataSourceImpl
    implements CarSearchHistoryRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarSearchHistoryRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<CarSearchHistoryModelDomainData> getCarSearchHistoryData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarSearchHistory.getSearchHistoryData(),
        queryName: QueryNames.shared.getCarRentalRecentSearches);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarSearchHistoryModelDomainData.fromMap(result.data!);
    }
  }
}
