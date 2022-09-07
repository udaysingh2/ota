import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_config_api.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';

abstract class ConfigRemoteDataSource {
  Future<ConfigResultModel> getConfigDetails();
}

class ConfigRemoteDataSourceImpl implements ConfigRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  ConfigRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<ConfigResultModel> getConfigDetails() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getConfigDetails,
        query: QueriesConfigApi.getConfigData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return ConfigResultModel.fromMap(result.data!);
    }
  }
}
