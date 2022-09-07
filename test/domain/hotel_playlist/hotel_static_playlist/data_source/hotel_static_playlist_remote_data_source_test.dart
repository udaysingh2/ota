import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedHotelStaticResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("hotel_playlist/hotel_static_playlist.json"));

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

  group('hotel static remote data source group', () {
    test('hotel static mock data source test', () async {
      HotelStaticPlayListRemoteDataSourceImpl.setMock(
          _MockedHotelStaticResponseImpl());

      HotelStaticPlayListRemoteDataSource hotelStaticPlayListRemoteDataSource =
          HotelStaticPlayListRemoteDataSourceImpl();

      hotelStaticPlayListRemoteDataSource.getHotelStaticPlayListData(
        HotelStaticPlayListArgumentModelDomain(
          epoch: '',
          userId: '',
          lat: 2.0,
          long: 2.0,
        ),
      );
    });

    test('hotel static remote data source test', () async {
      HotelStaticPlayListRemoteDataSource hotelStaticPlayListRemoteDataSource =
          HotelStaticPlayListRemoteDataSourceImpl(
              graphQlResponse: _MockedHotelStaticResponseImpl());
      hotelStaticPlayListRemoteDataSource.getHotelStaticPlayListData(
        HotelStaticPlayListArgumentModelDomain(
          epoch: '1654591450',
          userId: '',
          lat: 2.0,
          long: 2.0,
        ),
      );
    });
  });
}
