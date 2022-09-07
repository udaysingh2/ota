import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/data_sources/remove_promo_code_remote_data_sources.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedRemovePromoCodeResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("promo_engine/remove_promo_code_mock.json"));

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
  group('Remove Promo Code Remote Data Source Group Test', () {
    test('Remove Promo Code Mock Data Source Test', () async {
      RemovePromoCodeRemoteDataSourceImpl.setMock(
        MockedRemovePromoCodeResponseImpl(),
      );

      RemovePromoCodeRemoteDataSource remoteDataSource =
          RemovePromoCodeRemoteDataSourceImpl();

      remoteDataSource.removePromoCodeData(
        RemovePromoCodeArgumentDomain(bookingUrn: ''),
      );
    });

    test('Remove Promo Code Remote Data Source Test', () async {
      RemovePromoCodeRemoteDataSource remoteDataSource =
          RemovePromoCodeRemoteDataSourceImpl(
        graphQlResponse: MockedRemovePromoCodeResponseImpl(),
      );

      remoteDataSource.removePromoCodeData(
        RemovePromoCodeArgumentDomain(bookingUrn: ''),
      );
    });

    test('Remove Promo Code graphQlResponse null Test', () async {
      RemovePromoCodeRemoteDataSource remoteDataSource =
          RemovePromoCodeRemoteDataSourceImpl(
        graphQlResponse: null,
      );

      remoteDataSource.removePromoCodeData(
        RemovePromoCodeArgumentDomain(bookingUrn: ''),
      );
    });
  });
}
