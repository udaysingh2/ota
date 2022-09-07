import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_supplier.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';

/// Interface for Car Supplier Data remote data source.
abstract class CarSupplierRemoteDataSource {
  /// Call API to get the Car Supplier Screen details.
  /// [Either<Failure, CarSupplierModelDomain>] to handle the Failure or result data.
  Future<CarSupplierModelDomainData> getCarSupplierData(
      CarSupplierArgumentModel argument);
}

/// CarSupplierRemoteDataSourceImpl will contain the CarSupplierRemoteDataSource implementation.
class CarSupplierRemoteDataSourceImpl implements CarSupplierRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarSupplierRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<CarSupplierModelDomainData> getCarSupplierData(
      CarSupplierArgumentModel argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarSupplier.getCarSupplierData(argument),
        queryName: QueryNames.shared.getCarRentalSupplier);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      CarSupplierModelDomainData carSupplierModelDomain =
          CarSupplierModelDomainData.fromMap(result.data!);
      return carSupplierModelDomain;
    }
  }
}
