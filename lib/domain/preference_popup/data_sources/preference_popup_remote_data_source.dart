import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_preference_popup.dart';

/// Interface for Preference pop up detail Data remote data source.
/// Change the argument model
abstract class PreferencePopUpRemoteDataSource {
  Future<bool> getPopUpState(String id, String type, String endDate);
}

class PreferencePopUpRemoteDataSourceImpl
    implements PreferencePopUpRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PreferencePopUpRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<bool> getPopUpState(String id, String type, String endDate) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.userPreferencePopup,
        query: QueriesPreferencePopup.getPopUpState(id, type, endDate));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return !result.hasException;
    }
  }
}
