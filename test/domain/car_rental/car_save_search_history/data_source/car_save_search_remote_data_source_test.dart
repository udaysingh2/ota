import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map = json
      .decode(fixture("car_save_search_history/car_save_search_history.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      required String queryName,
      bool authRequired = true}) async {
    map["saveRecentCarRentalSearchHistory"] = map;
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
  CarSaveSearchHistoryArgumentDomain argument =
      CarSaveSearchHistoryArgumentDomain(
          cityId: "cityId",
          countryId: "countryId",
          locationId: "locationId",
          searchKey: "searchKey");

  group("Car save search history remote data source group", () {
    test('Car save search history remote data source', () async {
      CarSaveSearchHistoryRemoteDataSource
          carSaveSearchHistoryRemoteDataSource =
          CarSaveSearchHistoryRemoteDataSourceImpl();

      carSaveSearchHistoryRemoteDataSource =
          CarSaveSearchHistoryRemoteDataSourceImpl(
              graphQlResponse: _MockedGraphQlResponseImpl());
      carSaveSearchHistoryRemoteDataSource.saveCarSearchHistoryData(argument);
    });
    test('Car save search history remote data source', () async {
      GraphQlResponse graphQlResponseMessage = GraphQlResponseMock();

      CarSaveSearchHistoryRemoteDataSourceImpl.setMock(graphQlResponseMessage);
    });
  });
}
