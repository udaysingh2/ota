import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_search_filter.dart';
import 'package:ota/domain/car_rental/car_search_filter/model/car_search_filter_domain_model.dart';

abstract class CarSearchFilterRemoteDataSource {
  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchFilterDomainModel>] to handle the Failure or result data.
  Future<CarSearchFilterDomainModel> getCarSearchFilterData();
}

/// CarSearchFilterRemoteDataSourceImpl will contain the CarSearchFilterRemoteDataSource implementation.
class CarSearchFilterRemoteDataSourceImpl
    implements CarSearchFilterRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarSearchFilterRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  /// [Either<Failure, CarSearchFilterDomainModel>] to handle the Failure or result data.
  @override
  Future<CarSearchFilterDomainModel> getCarSearchFilterData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
      query: QueriesCarSearchFilter.getCarSearchFilterData(),
      queryName: QueryNames.shared.getSortCriteriaForService,
    );
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      CarSearchFilterDomainModel carSearchFilterDomainModel =
          CarSearchFilterDomainModel.fromMap(
              result.data?["getSortCriteriaForService"]);
      return carSearchFilterDomainModel;
    }
  }
}
