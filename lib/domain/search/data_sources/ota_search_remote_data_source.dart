import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_seach.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';

/// Interface for ota search remote source.
abstract class OtaSearchRemoteDataSource {
  /// [Either<Failure, OtaSearchData>] to handle the Failure or result data.
  Future<OtaSearchData> getOtaSearchData(OtaSearchDataArgument argument);
}

/// OtaSearchRemoteDataSourceImpl will contain the OtaSearchRemoteDataSource implementation.
class OtaSearchRemoteDataSourceImpl implements OtaSearchRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  OtaSearchRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the ota search details.
  ///
  /// [Either<Failure, OtaSearchData>] to handle the Failure or result data.
  @override
  Future<OtaSearchData> getOtaSearchData(OtaSearchDataArgument argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getOtaSearchResult,
        query: QueriesOtaSearch.getOtaSearchData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return OtaSearchData.fromMap(result.data!);
    }
  }
}
