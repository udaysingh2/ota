import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_data_source_mock.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';

import '../../../mocks/fixture_reader.dart';

class _MockedGraphQlResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map = json.decode(fixture(
      "hotel/hotel_landing_playlist/hotel_landing_dynamic_playlist.json"));

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
  HotelLandingDynamicSingleDataArgument argument =
      HotelLandingDynamicSingleDataArgument(
          playlistId: "playlistId", userId: "userId");

  group("Hotel landing dynamic playlist remote data source group", () {
    test('Hotel landing dynamic playlist remote data source test', () async {
      HotelLandingDynamicDataSource hotelLandingDynamicDataSource =
          HotelLandingDynamicDataSourceImpl();
      hotelLandingDynamicDataSource = HotelLandingDynamicDataSourceImpl(
          graphQlResponse: _MockedGraphQlResponseImpl());
      hotelLandingDynamicDataSource.getPlaylist(argument);
    });
    test('Hotel landing dynamic playlist remote data source test1', () async {
      GraphQlResponse graphQlResponseMessage = GraphQlResponseMock(
          result:
              jsonDecode(HotelLandingDynamicMockDataSourceImpl.getMockData()));
      HotelLandingDynamicDataSourceImpl.setMock(graphQlResponseMessage);
      HotelLandingDynamicDataSource hotelLandingDynamicDataSource =
          HotelLandingDynamicDataSourceImpl();
      hotelLandingDynamicDataSource.getPlaylist(argument);
    });
  });
}
