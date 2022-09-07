import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_landing_page.dart';
import 'package:ota/domain/landing/models/landing_models.dart';

/// Interface for Room detail Data remote data source.
/// Change the argument model
abstract class LandingPageRemoteDataSource {
  Future<LandingData> getLandingPage();
}

class LandingPageRemoteDataSourceImpl implements LandingPageRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  LandingPageRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<LandingData> getLandingPage() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getLandingPageDetails,
        query: QueriesLanding.getLandingPageData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return LandingData.fromMap(result.data);
    }
  }
}
