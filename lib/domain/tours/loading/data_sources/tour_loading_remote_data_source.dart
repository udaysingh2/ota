import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_loading.dart';
import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';

/// Interface for HotelServiceRemoteDataSource data source.
abstract class TourLoadingRemoteDataSource {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon service Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<TourLoadingData> getTourLoadingData();
}

/// HotelServiceRemoteDataSourceImpl will contain the HotelServiceRemoteDataSource implementation.
class TourLoadingRemoteDataSourceImpl implements TourLoadingRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  TourLoadingRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon service Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<TourLoadingData> getTourLoadingData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getTourLoadingData,
        query: QueriesOtaLoading.getTourLoadingScreenData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return TourLoadingData.fromMap(result.data!);
    }
  }
}
