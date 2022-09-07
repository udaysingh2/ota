import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/insurance/data_source/insurance_data_source.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';

import '../../../mocks/fixture_reader.dart';

class MockInsuranceGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("insurance/insurance_mock.json"));
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
  InsuranceArgumentDomain argument =
      InsuranceArgumentDomain(limit: 0, offset: 0, recommendedServices: "");

  group("Insurance data source group", () {
    test('Insurance test', () async {
      InsuranceRemoteDataSource insuranceRemoteDataSource =
          InsuranceRemoteDataSourceImpl();
      insuranceRemoteDataSource = InsuranceRemoteDataSourceImpl(
          graphQlResponse: MockInsuranceGraphQl());
      InsuranceRemoteDataSourceImpl.setMock(MockInsuranceGraphQl());
      insuranceRemoteDataSource.getInsuranceData(argument);
    });
  });
}
