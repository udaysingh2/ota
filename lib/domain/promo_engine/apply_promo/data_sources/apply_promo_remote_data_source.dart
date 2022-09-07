import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_promo_code_apply.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';

abstract class ApplyPromoRemoteDataSource {
  Future<ApplyPromoModelDomain> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain);
}

class ApplyPromoRemoteDataSourceImpl implements ApplyPromoRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  ApplyPromoRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<ApplyPromoModelDomain> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        queryName: QueryNames.shared.applyPromoCode,
        query: QueriesPromoApply.applyPromoCode(applyPromoArgumentDomain));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return ApplyPromoModelDomain.fromMap(result.data!);
    }
  }
}
