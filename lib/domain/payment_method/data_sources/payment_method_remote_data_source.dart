import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_payment_method.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';

/// Interface for Payment Method Data remote data source.
abstract class PaymentMethodRemoteDataSource {
  /// Call API to get the Payment Method Screen details.
  ///
  /// [userId] to get the Payment Method Data for users.
  /// [Either<Failure, PaymentMethodModelDomain>] to handle the Failure or result data.
  Future<PaymentMethodModelDomain> getPaymentMethodListData(String userId);
}

/// PaymentMethodRemoteDataSourceImpl will contain the PaymentMethodRemoteDataSource implementation.
class PaymentMethodRemoteDataSourceImpl
    implements PaymentMethodRemoteDataSource {
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  GraphQlResponse? graphQlResponse;
  PaymentMethodRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Payment Method Screen details.
  ///
  /// [userId] to get the Payment Method Data for users.
  /// [Either<Failure, PaymentMethodModelDomain>] to handle the Failure or result data.
  @override
  Future<PaymentMethodModelDomain> getPaymentMethodListData(
      String userId) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getCustomerPaymentMethodDetails,
        query: QueriesPaymentMethod.getPaymentMethodListData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PaymentMethodModelDomain.fromMap(result.data!);
    }
  }
}
