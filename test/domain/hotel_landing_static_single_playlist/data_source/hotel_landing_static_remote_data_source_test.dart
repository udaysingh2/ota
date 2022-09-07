import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_data_source_mock.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';

import '../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture(
      "hotel/hotel_landing_playlist/hotel_landing_static_playlist.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      required String queryName,
      bool authRequired = true}) async {
    map["getPlaylists"] = map;
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
  HotelLandingStaticSingleDataArgument argument =
      HotelLandingStaticSingleDataArgument(
          playlistId: "playlistId", userId: "userId");

  group("Hotel landing static playlist remote data source group", () {
    test('Hotel landing static playlist remote data source test', () async {
      HotelLandingStaticDataSource hotelLandingStaticDataSource =
          HotelLandingStaticDataSourceImpl();
      hotelLandingStaticDataSource = HotelLandingStaticDataSourceImpl(
          graphQlResponse: _MockedGraphQlResponseImpl());
      hotelLandingStaticDataSource.getPlaylist(argument);
    });
    test('Hotel landing static playlist remote data source test', () async {
      GraphQlResponse graphQlResponseMessage = GraphQlResponseMock(
          result:
              jsonDecode(HotelLandingStaticMockDataSourceImpl.getMockData()));
      HotelLandingStaticDataSourceImpl.setMock(graphQlResponseMessage);
      HotelLandingStaticDataSource hotelLandingStaticDataSource =
          HotelLandingStaticDataSourceImpl();

      hotelLandingStaticDataSource.getPlaylist(argument);
    });
  });
}
