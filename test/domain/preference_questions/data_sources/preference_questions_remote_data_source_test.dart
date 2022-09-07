import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';

import '../../../mocks/fixture_reader.dart';

class MockPreferenceQuestionsGraphQl implements GraphQlResponse {
  Map<String, dynamic> map = json
      .decode(fixture("preference_questions/preference_questions_mock.json"));
  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      //This is mandatory for crashlytics
      required String queryName,
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
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

  group("Preference Questions remote data source group", () {
    test('Preference Questions test', () async {
      PreferenceQuestionsRemoteDataSource preferenceQuestionsRemoteDataSource =
          PreferenceQuestionsRemoteDataSourceImpl();
      preferenceQuestionsRemoteDataSource =
          PreferenceQuestionsRemoteDataSourceImpl(
              graphQlResponse: MockPreferenceQuestionsGraphQl());
      PreferenceQuestionsRemoteDataSourceImpl.setMock(
          MockPreferenceQuestionsGraphQl());
      preferenceQuestionsRemoteDataSource.getPreferencesData();
    });
  });
}
