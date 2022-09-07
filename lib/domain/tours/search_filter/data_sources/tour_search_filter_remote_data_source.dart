import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_filter_result.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';

abstract class TourSearchFilterRemoteDataSource {
  Future<TourSearchFilterModelDomain> getTourSearchFilterData(
      String serviceType);
}

class TourSearchFilterRemoteDataSourceImpl
    implements TourSearchFilterRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourSearchFilterRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TourSearchFilterModelDomain> getTourSearchFilterData(
      serviceType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourSearchFilterData,
        query: QueriesTourFilterResult.getTourSortFilterData(serviceType));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourSearchFilterModelDomain.fromMap(result.data!);
    }
  }
}
