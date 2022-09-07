import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_remote_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class MockApplyPromoGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("promo_engine/apply_promo_mock.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      required String queryName,
      bool authRequired = true}) async {
    QueryResult queryResult = QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
    return queryResult;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  ApplyPromoArgumentDomain argument = ApplyPromoArgumentDomain(
      bookingUrn: "",
      promotionDetailsModel: PromotionDetailsModel(
          applicationKey: "",
          discount: 0,
          discountFor: "",
          discountType: "",
          promotionCode: "",
          promotionId: 0,
          promotionLink: "",
          promotionType: "",
          shortDescription: "",
          promotionName: "",
          voucherCode: "",
          maximumDiscount: 0,
          iconUrl: "",
          merchantId: "",
          endDate: DateTime.now(),
          startDate: DateTime.now()));

  group("Apply Promo data source group", () {
    test('Apply Promo Mailer test', () async {
      ApplyPromoRemoteDataSource applyPromoRemoteDataSource =
          ApplyPromoRemoteDataSourceImpl();
      applyPromoRemoteDataSource = ApplyPromoRemoteDataSourceImpl(
          graphQlResponse: MockApplyPromoGraphQl());
      ApplyPromoRemoteDataSourceImpl.setMock(MockApplyPromoGraphQl());
      applyPromoRemoteDataSource.applyPromoCode(argument);
    });
  });
}
