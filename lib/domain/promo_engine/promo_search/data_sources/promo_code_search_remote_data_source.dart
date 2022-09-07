import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_promo_code_search.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';

abstract class PromoCodeSearchRemoteDataSource {
  Future<PromoCodeSearchModelDomain> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain);
}

class PromoCodeSearchRemoteDataSourceImpl
    implements PromoCodeSearchRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PromoCodeSearchRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<PromoCodeSearchModelDomain> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        queryName: QueryNames.shared.searchPromoCode,
        query: QueriesPromoSearch.searchPromoCode(promoCodeArgumentDomain));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PromoCodeSearchModelDomain.fromMap(result.data!);
    }
  }
}
