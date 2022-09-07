import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_preferences.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';

/// Interface for PreferencesSubmitRemoteDataSource data source.
abstract class PreferencesSubmitRemoteDataSource {
  /// Call API to submit the preferences Screen details.
  ///
  /// [preferencesArgumentDomain] to to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  Future<PreferencesSubmitModelDomain> submitPreferencesData(
      PreferencesSubmitArgumentDomain preferencesArgumentDomain);
}

/// PreferencesSubmitRemoteDataSourceImpl will contain the PreferencesSubmitRemoteDataSource implementation.
class PreferencesSubmitRemoteDataSourceImpl
    implements PreferencesSubmitRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PreferencesSubmitRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  Future<PreferencesSubmitModelDomain> submitPreferencesData(
      PreferencesSubmitArgumentDomain preferencesSubmitArgument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.createPreference,
        query:
            QueriesPreferences.submitPreferenceData(preferencesSubmitArgument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PreferencesSubmitModelDomain.fromMap(result.data!);
    }
  }
}
