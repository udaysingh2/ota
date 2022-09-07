import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_pickup_point.dart';
import 'package:ota/domain/tours/review_reservation/models/pickup_point_model_domain.dart';

/// Interface for PickUpPoint Data remote data source.
abstract class PickUpPointRemoteDataSource {
  Future<PickUpPointDomain> getPickUpPointDetail(String zoneId);
}

class PickUpPointRemoteDataSourceImpl implements PickUpPointRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PickUpPointRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<PickUpPointDomain> getPickUpPointDetail(String zoneId) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getPickUpPointDetail,
        query: QueriesPickUpPoint.getPickUpPointDetail(zoneId));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PickUpPointDomain.fromMap(result.data!);
    }
  }
}
