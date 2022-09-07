import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_insurance.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';

abstract class InsuranceRemoteDataSource {
  Future<InsuranceModelDomain> getInsuranceData(
      InsuranceArgumentDomain argumentModel);
}

class InsuranceRemoteDataSourceImpl implements InsuranceRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  InsuranceRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<InsuranceModelDomain> getInsuranceData(
      InsuranceArgumentDomain argumentModel) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        queryName: QueryNames.shared.getInsurance,
        query: QueriesInsurance.getInsurance(argumentModel));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return InsuranceModelDomain.fromMap(result.data!);
    }
  }
}
