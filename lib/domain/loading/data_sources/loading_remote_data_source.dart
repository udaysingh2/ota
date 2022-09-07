import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_loading.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

/// Interface for Loading Data remote data source.
abstract class LoadingRemoteDataSource {
  /// Call API to get the Loading Screen details.
  /// [Either<Failure, LoadingModel>] to handle the Failure or result data.
  Future<LoadingModelData> getLoadingData(String serviceName);
}

/// LoadingRemoteDataSourceImpl will contain the LoadingRemoteDataSource implementation.
class LoadingRemoteDataSourceImpl implements LoadingRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  LoadingRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Loading Screen details.
  ///
  /// [Either<Failure, LoadingModel>] to handle the Failure or result data.
  @override
  Future<LoadingModelData> getLoadingData(String serviceName) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getLoadScreen,
        query: QueriesLoading.getLoadingScreenData(serviceName));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      final String resultString = json.encode(result.data!);
      OtaPreference.shared.setLoadingJsonData(resultString);
      return LoadingModelData.fromMap(result.data!);
    }
  }
}
