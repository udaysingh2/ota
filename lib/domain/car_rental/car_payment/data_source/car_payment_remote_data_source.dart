import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_payment.dart';
import '../models/car_payment_argument_model.dart';
import '../models/car_payment_model_domain.dart';

abstract class CarPaymentRemoteDataSource {
  Future<CarPaymentDomainModelData> getCarPaymentData(
      CarPaymentDomainArgumentModel argument);
}

class CarPaymentRemoteDataSourceImpl implements CarPaymentRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarPaymentRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<CarPaymentDomainModelData> getCarPaymentData(
      CarPaymentDomainArgumentModel argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarPayment.getCarPaymentData(argument),
        queryName: QueryNames.shared.getCarPaymentData);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarPaymentDomainModelData.fromMap(result.data!);
    }
  }
}
