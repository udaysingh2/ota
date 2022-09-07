import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_ota_update_customer.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';

/// Interface for HotelServiceRemoteDataSource data source.
abstract class OtaUpdateCustomerRemoteDataSource {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon service Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<OtaUpdateCustomerDetailsData> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain contactInformationArgumentData);
}

/// HotelServiceRemoteDataSourceImpl will contain the HotelServiceRemoteDataSource implementation.
class OtaUpdateCustomerRemoteDataSourceImpl
    implements OtaUpdateCustomerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  OtaUpdateCustomerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  Future<OtaUpdateCustomerDetailsData> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain
          contactInformationArgumentData) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
      //This is mandatory for crashlytics provide the query name here
      queryName: QueryNames.shared.updateCustomerDetails,
      query: OtaQueriesUpdateCustomer.updateCustomerDetails(
          contactInformationArgumentData),
    );
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      OtaUpdateCustomerDetailsData updateCustomerData =
          OtaUpdateCustomerDetailsData.fromMap(result.data!);
      return updateCustomerData;
    }
  }
}
