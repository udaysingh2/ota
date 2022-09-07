import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_service_card.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';

abstract class ServiceCardRemoteDataSource {
  Future<ServiceCardModelDomainData> getServiceCardData();
}

class ServiceCardRemoteDataSourceImpl implements ServiceCardRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  ServiceCardRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<ServiceCardModelDomainData> getServiceCardData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getServiceCard,
        query: QueriesServiceCard.getServiceCard());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return ServiceCardModelDomainData.fromMap(result.data!);
    }
  }
}
