import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/promo_engine/promo_search/data_sources/promo_code_search_remote_data_source.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedPromoCodeSearchResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("promo_engine/promo_code_search_mock.json"));

  @override
  Future<QueryResult> getGraphQlResponse({
    String query = '',
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
    String? acceptLanguage,
    String? bookingUrn,
    String? voucherCode,
    String? applicationKey,
    required String queryName,
    bool authRequired = true,
  }) async {
    map["searchPromoCode"] = map;
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
  group('Promo Code Search Remote Data Source Group Test', () {
    test('Promo Code Search Mock Data Source Test', () async {
      PromoCodeSearchRemoteDataSourceImpl.setMock(
        MockedPromoCodeSearchResponseImpl(),
      );

      PromoCodeSearchRemoteDataSource remoteDataSource =
          PromoCodeSearchRemoteDataSourceImpl();

      remoteDataSource.searchPromoCode(
        PromoCodeArgumentDomain(
          applicationKey: '',
        ),
      );
    });

    test('Promo Code Search Remote Data Source Test', () async {
      PromoCodeSearchRemoteDataSource remoteDataSource =
          PromoCodeSearchRemoteDataSourceImpl(
        graphQlResponse: MockedPromoCodeSearchResponseImpl(),
      );

      remoteDataSource.searchPromoCode(
        PromoCodeArgumentDomain(applicationKey: ''),
      );
    });

    test('Promo Code Search graphQlResponse null Test', () async {
      PromoCodeSearchRemoteDataSource remoteDataSource =
          PromoCodeSearchRemoteDataSourceImpl(
        graphQlResponse: null,
      );

      remoteDataSource.searchPromoCode(
        PromoCodeArgumentDomain(applicationKey: ''),
      );
    });
  });
}
