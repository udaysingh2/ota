import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_recommended_locations.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

/// Interface for Hotel detail Data remote data source.
abstract class RecommendedLocationRemoteDataSource {
  Future<RecommendedLocationModelDomain> getRecommendedLocationData(
      String serviceType);
}

class RecommendedLocationRemoteDataSourceImpl
    implements RecommendedLocationRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  RecommendedLocationRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<RecommendedLocationModelDomain> getRecommendedLocationData(
      String serviceType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getRecommendedLocation,
        query:
            QueriesRecommendedLocation.getRecommendedLocationData(serviceType));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RecommendedLocationModelDomain.fromMap(result.data!);
    }
  }
}
