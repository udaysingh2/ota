import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_virtual_payment.dart';
import 'package:ota/domain/virtual_account/models/virtual_payment_model_domain.dart';

abstract class VirtualPaymentRemoteDataSource {
  Future<VirtualPaymentModelDomain> getVirtualWalletBalance();
}

class VirtualPaymentRemoteDataSourceImpl
    implements VirtualPaymentRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  VirtualPaymentRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<VirtualPaymentModelDomain> getVirtualWalletBalance() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        queryName: QueryNames.shared.getVaBalance,
        query: QueriesVirtualPayment.getVirtualWalletBalance());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return VirtualPaymentModelDomain.fromMap(result.data!);
    }
  }
}
