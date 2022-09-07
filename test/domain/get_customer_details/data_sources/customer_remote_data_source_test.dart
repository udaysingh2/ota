import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';

import '../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("get_customer_details/customer_details.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      //This is mandatory for crashlytics
      required String queryName,
      String? bookingUrn,
      bool authRequired = true}) async {
    map["getCustomerDetails"] = map;
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

  group("customer remote data source group", () {
    test('customer remote data source', () async {
      CustomerRemoteDataSource customerRemoteDataSource =
          CustomerRemoteDataSourceImpl();
      customerRemoteDataSource = CustomerRemoteDataSourceImpl(
          graphQlResponse: _MockedGraphQlResponseImpl());
      customerRemoteDataSource.getCustomerData();
    });

    test('customer remote data source ==> With setMock() Test', () async {
      CustomerRemoteDataSource customerRemoteDataSource =
          CustomerRemoteDataSourceImpl();

      CustomerRemoteDataSourceImpl.setMock(_MockedGraphQlResponseImpl());

      customerRemoteDataSource = CustomerRemoteDataSourceImpl(
          graphQlResponse: _MockedGraphQlResponseImpl());
      customerRemoteDataSource.getCustomerData();
    });
  });
}
