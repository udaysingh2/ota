import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_search_result.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

abstract class CarSearchResultRemoteDataSource {
  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchResultDomainModel>] to handle the Failure or result data.
  Future<CarSearchResultDomainModel> getCarSearchResultData(
    CarSearchResultDomainArgumentModel argument,
    int pageNumber,
    int pageSize,
    LocationModel? pickupLocation,
    LocationModel? dropLocation,
    String dataSearchType,
    bool isSearchSave,
  );
}

/// CarSearchResultRemoteDataSourceImpl will contain the CarSearchResultRemoteDataSource implementation.
class CarSearchResultRemoteDataSourceImpl
    implements CarSearchResultRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarSearchResultRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchResultDomainModel>] to handle the Failure or result data.
  @override
  Future<CarSearchResultDomainModel> getCarSearchResultData(
      CarSearchResultDomainArgumentModel argument,
      int pageNumber,
      int pageSize,
      LocationModel? pickupLocation,
      LocationModel? dropLocation,
      String dataSearchType,
      bool isSearchSave) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
      query: QueriesCarSearchResult.getCarSearchResultData(
        argument,
        pageNumber,
        pageSize,
        pickupLocation,
        dropLocation,
        dataSearchType,
        isSearchSave,
      ),
      queryName: QueryNames.shared.getCarRentalSearchResult,
    );
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      CarSearchResultDomainModel carSearchResultDomainModel =
          CarSearchResultDomainModel.fromMap(
              result.data?["getCarRentalSearchResult"]);
      return carSearchResultDomainModel;
    }
  }
}
