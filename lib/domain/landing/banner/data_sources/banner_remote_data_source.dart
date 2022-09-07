import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_landing_banner.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';

/// Interface for Room detail Data remote data source.
/// Change the argument model
abstract class LandingBannerRemoteDataSource {
  Future<LandingBannerModelDomain> getLandingBanner(String bannerType);
}

class LandingBannerRemoteDataSourceImpl
    implements LandingBannerRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  LandingBannerRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<LandingBannerModelDomain> getLandingBanner(String bannerType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getBanners,
        query: QueriesLandingBanner.getLandingBannerData(bannerType));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return LandingBannerModelDomain.fromMap(result.data!);
    }
  }
}
