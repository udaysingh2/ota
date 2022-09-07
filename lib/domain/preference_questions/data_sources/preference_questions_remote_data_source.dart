import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_preference_questions.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';

/// Interface for PreferencesQuestionsRemoteDataSource data source.
abstract class PreferenceQuestionsRemoteDataSource {
  /// Call API to get the preferences Data.
  ///
  /// [preferencesArgumentDomain] to to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  Future<PreferenceQuestionsModelDomainData> getPreferencesData();
}

/// PreferencesSubmitRemoteDataSourceImpl will contain the PreferencesSubmitRemoteDataSource implementation.
class PreferenceQuestionsRemoteDataSourceImpl
    implements PreferenceQuestionsRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PreferenceQuestionsRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to submit the preferences Screen details.
  ///
  /// [preferencesSubmitArgument] to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  @override
  Future<PreferenceQuestionsModelDomainData> getPreferencesData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getPreferences,
        query: QueriesPreferenceQuestions.getPreferences());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PreferenceQuestionsModelDomainData.fromMap(result.data!);
    }
  }
}
