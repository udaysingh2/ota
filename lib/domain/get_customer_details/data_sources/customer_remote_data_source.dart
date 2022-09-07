import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_user_data.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';

/// Interface for HotelServiceRemoteDataSource data source.
abstract class CustomerRemoteDataSource {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon service Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<CustomerData> getCustomerData();
}

/// HotelServiceRemoteDataSourceImpl will contain the HotelServiceRemoteDataSource implementation.
class CustomerRemoteDataSourceImpl implements CustomerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CustomerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  Future<CustomerData> getCustomerData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getCustomerDetails,
        query: QueriesUserData.get());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CustomerData.fromMap(result.data!["getCustomerDetails"]);
    }
  }
}
