import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotiom_remote_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedPublicPromoCodeResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("promo_engine/public_promo_code_mock.json"));

  @override
  Future<QueryResult> getGraphQlResponse({
    String query = '',
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
    String? acceptLanguage,
    String? bookingUrn,
    required String queryName,
    bool authRequired = true,
  }) async {
    map["removePromoCode"] = map;
    return QueryResult(
      source: QueryResultSource.optimisticResult,
      data: map,
      options: QueryOptions(
        fetchPolicy: fetchPolicy,
        document: gql(query),
      ),
    );
  }
}

void main() {
  group('Public Promo Code Remote Data Source Group Test', () {
    test('Public Promo Code Mock Data Source Test', () async {
      PublicPromotionRemoteDataSourceImpl.setMock(
        MockedPublicPromoCodeResponseImpl(),
      );

      PublicPromotionRemoteDataSource remoteDataSource1 =
          PublicPromotionRemoteDataSourceImpl();

      remoteDataSource1.getPublicPromotionData(
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''),
      );
    });

    test('public Promo Code Remote Data Source Test', () async {
      PublicPromotionRemoteDataSource remoteDataSource =
          PublicPromotionRemoteDataSourceImpl(
        graphQlResponse: MockedPublicPromoCodeResponseImpl(),
      );

      remoteDataSource.getPublicPromotionData(
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''),
      );
    });

    test('public Promo Code graphQlResponse null Test', () async {
      PublicPromotionRemoteDataSource remoteDataSource1 =
          PublicPromotionRemoteDataSourceImpl(
        graphQlResponse: null,
      );

      remoteDataSource1.getPublicPromotionData(
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''),
      );
    });
  });
}
