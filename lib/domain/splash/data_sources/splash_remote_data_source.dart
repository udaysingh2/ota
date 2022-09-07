import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_general.dart';
import 'package:ota/domain/splash/models/splash_model.dart';

/// Interface for splash Data remote data source.
abstract class SplashRemoteDataSource {
  /// Call API to get the splash Screen details.
  /// [Either<Failure, SplashModel>] to handle the Failure or result data.
  Future<SplashModel> getSplashData();
}

/// SplashRemoteDataSourceImpl will contain the SplashRemoteDataSource implementation.
class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  SplashRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the splash Screen details.
  ///
  /// [Either<Failure, SplashModel>] to handle the Failure or result data.
  @override
  Future<SplashModel> getSplashData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getSplashScreen,
        query: QueriesGeneral.getSplashScreenData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SplashModel.fromMap(result.data!);
    }
  }
}
