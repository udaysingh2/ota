import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';

import '../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("ota_search_sort/search_sort.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      //This is mandatory for crashlytics
      required String queryName,
      String? bookingUrn,
      bool authRequired = true}) async {
    map["getSortCriteriaForService"] = map;
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
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Ota search Filter remote data source group", () {
    test('Ota search Filter remote data source', () async {
      OtaSearchSortRemoteDataSource otaSearchSortRemoteDataSource =
          OtaSearchSortRemoteDataSourceImpl();
      otaSearchSortRemoteDataSource = OtaSearchSortRemoteDataSourceImpl(
          graphQlResponse: _MockedGraphQlResponseImpl());
      otaSearchSortRemoteDataSource.getOtaSearchSortData();
    });
  });
}
