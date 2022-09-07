import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_popup.dart';
import 'package:ota/domain/popup/models/popup_models.dart';

/// Interface for Room detail Data remote data source.
/// Change the argument model
abstract class PopupRemoteDataSource {
  Future<PopupModelDomain> getPopup();
}

class PopupRemoteDataSourceImpl implements PopupRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  PopupRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<PopupModelDomain> getPopup() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getPopups,
        query: QueriesPopup.getPopupData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PopupModelDomain.fromMap(result.data!);
    }
  }
}
