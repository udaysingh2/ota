import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_update_customer.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

/// Interface for HotelServiceRemoteDataSource data source.
abstract class UpdateCustomerRemoteDataSource {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon service Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<UpdateCustomerData> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData);
}

/// HotelServiceRemoteDataSourceImpl will contain the HotelServiceRemoteDataSource implementation.
class UpdateCustomerRemoteDataSourceImpl
    implements UpdateCustomerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  UpdateCustomerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  Future<UpdateCustomerData> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.updateCustomerDetails,
        query: QueriesUpdateCustomer.updateCustomerData(
            contactInformationArgumentData));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      UpdateCustomerData updateCustomerData =
          UpdateCustomerData.fromMap(result.data!);
      return updateCustomerData;
    }
  }
}
