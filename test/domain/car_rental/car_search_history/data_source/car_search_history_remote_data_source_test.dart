import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("car_search_history/car_search_history.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      required String queryName,
      bool authRequired = true}) async {
    map["getCarRentalRecentSearches"] = map;
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

  group("Car search history remote data source group", () {
    test('Car  search history remote data source', () async {
      CarSearchHistoryRemoteDataSource carSearchHistoryRemoteDataSource =
          CarSearchHistoryRemoteDataSourceImpl();

      carSearchHistoryRemoteDataSource = CarSearchHistoryRemoteDataSourceImpl(
          graphQlResponse: _MockedGraphQlResponseImpl());
      carSearchHistoryRemoteDataSource.getCarSearchHistoryData();
    });
    test('Car search history remote data source', () async {
      GraphQlResponse graphQlResponseMessage = GraphQlResponseMock();

      CarSearchHistoryRemoteDataSourceImpl.setMock(graphQlResponseMessage);
    });
  });
}
