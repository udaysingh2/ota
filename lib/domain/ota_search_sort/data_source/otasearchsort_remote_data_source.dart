import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_filter_sort.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';

/// Interface for OtaSearchSort Data remote data source.
abstract class OtaSearchSortRemoteDataSource {
  /// Call API to get the OtaSearchSort Screen details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  Future<OtaFilterSort> getOtaSearchSortData();
}

/// OtaSearchSortRemoteDataSourceImpl will contain the OtaSearchSortRemoteDataSource implementation.
class OtaSearchSortRemoteDataSourceImpl
    implements OtaSearchSortRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  OtaSearchSortRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the OtaSearchSort Screen details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  @override
  Future<OtaFilterSort> getOtaSearchSortData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getSortCriteriaForService,
        query: QueriesOtaFilterSort.getOtaFilterSortData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return OtaFilterSort.fromMap(result.data!["getSortCriteriaForService"]!);
    }
  }
}
