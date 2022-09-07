import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_tour_attractions.dart';
import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';

abstract class TourAttractionsRemoteDataSource {
  Future<TourAttractionsModelDomain> getTourAttractionsData(String serviceType);
}

class TourAttractionsRemoteDataSourceImpl
    implements TourAttractionsRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourAttractionsRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<TourAttractionsModelDomain> getTourAttractionsData(
      String serviceType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourAttractionsData,
        query: QueriesTourAttractions.getTourAttractionsData(serviceType));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourAttractionsModelDomain.fromMap(result.data!);
    }
  }
}
