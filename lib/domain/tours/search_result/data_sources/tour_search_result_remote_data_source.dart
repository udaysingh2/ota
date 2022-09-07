import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_search_result.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';

abstract class TourSearchResultRemoteDataSource {
  Future<TourSearchResultModelDomain> getTourSearchResultData(
      TourSearchResultArgumentDomain argument);
}

class TourSearchResultRemoteDataSourceImpl
    implements TourSearchResultRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourSearchResultRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TourSearchResultModelDomain> getTourSearchResultData(argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourSearchResultData,
        query: QueriesTourSearchResult.getTourSearchResultData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourSearchResultModelDomain.fromMap(result.data!);
    }
  }
}
