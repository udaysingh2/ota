import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_public_promotion.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';

/// Interface for Service card Data remote data source.
abstract class PublicPromotionRemoteDataSource {
  Future<PublicPromotionModelDomain> getPublicPromotionData(
      PublicPromotionArgumentDomain argument);
}

class PublicPromotionRemoteDataSourceImpl
    implements PublicPromotionRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PublicPromotionRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<PublicPromotionModelDomain> getPublicPromotionData(
      PublicPromotionArgumentDomain argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getAvailablePublicPromotions,
        query: QueriesPublicPromotion.getPublicPromotionData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PublicPromotionModelDomain.fromMap(result.data!);
    }
  }
}
