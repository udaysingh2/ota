import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/playlist/static_playlist/data_sources/static_playlist_remote_data_source.dart';

import '../../../../mocks/fixture_reader.dart';

class MockStaticPlaylistGraphQl implements GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("playlist/static_playlist_model_domain.json"));
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

  group("Static Playlist remote data source group", () {
    test('Static Playlist test', () async {
      StaticPlayListRemoteDataSource staticPlaylistRemoteDataSource =
          StaticPlayListRemoteDataSourceImpl();
      staticPlaylistRemoteDataSource = StaticPlayListRemoteDataSourceImpl(
          graphQlResponse: MockStaticPlaylistGraphQl());
      StaticPlayListRemoteDataSourceImpl.setMock(MockStaticPlaylistGraphQl());
      staticPlaylistRemoteDataSource.getStaticPlayListData();
    });
  });
}
