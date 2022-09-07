import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_authentication.dart';
import 'package:ota/domain/authentication/models/login_detail.dart';
import 'package:ota/domain/authentication/models/logout_detail.dart';
import 'package:ota/domain/authentication/models/refresh_detail.dart';

/// Interface for Auth Data remote data source.
abstract class AuthRemoteDataSource {
  Future<LoginDetail> getLoginDetail(
      {required String username, required String password});
  Future<RefreshDetail> refreshToken(String refreshToken);
  Future<LogoutDetail> logOut(String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  AuthRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  @override
  Future<LoginDetail> getLoginDetail(
      {required String username, required String password}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getLoginDetails,
        query:
            QueriesAuth.getLoginDetail(username: username, password: password));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return LoginDetail.fromMap(result.data!);
    }
  }

  @override
  Future<RefreshDetail> refreshToken(String refreshToken) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getRefreshToken,
        query: QueriesAuth.getRefreshDetail(refreshToken),
        authRequired: false);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RefreshDetail.fromMap(result.data!);
    }
  }

  @override
  Future<LogoutDetail> logOut(String username) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getLogoutDetails,
        query: QueriesAuth.getLogOutDetail(username));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return LogoutDetail.fromMap(result.data!);
    }
  }
}
