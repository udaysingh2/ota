import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_remove_promo_code.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';

abstract class RemovePromoCodeRemoteDataSource {
  Future<RemovePromoCodeModelDomain> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain);
}

class RemovePromoCodeRemoteDataSourceImpl
    implements RemovePromoCodeRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  RemovePromoCodeRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  ///API call to remove promo code
  @override
  Future<RemovePromoCodeModelDomain> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
      //This is mandatory for crashlytics provide the query name here
      queryName: QueryNames.shared.removePromoCode,
      query: QueriesRemovePromoCode.removePromoCodeData(argumentDomain),
    );
    if (result.hasException) {
      throw exp.ServerException(result.exception);
    } else {
      return RemovePromoCodeModelDomain.fromMap(result.data!);
    }
  }
}
