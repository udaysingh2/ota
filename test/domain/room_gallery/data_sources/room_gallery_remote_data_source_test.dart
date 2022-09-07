import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';

import '../../../mocks/fixture_reader.dart';

class _MockedRoomGalleryResponseImpl extends GraphQlResponse {
  Map<String, dynamic> map =
      json.decode(fixture("room_gallery/room_gallery_mock.json"));

  @override
  Future<QueryResult> getGraphQlResponse(
      {String query = '',
      //This is mandatory for crashlytics
      required String queryName,
      FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
      String? acceptLanguage,
      String? bookingUrn,
      bool authRequired = true}) async {
    map["getRoomImages"] = map;
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

  group('room gallery remote data source group', () {
    test('room gallery Mock data source test', () async {
      RoomGalleryRemoteDataSourceImpl.setMock(_MockedRoomGalleryResponseImpl());

      RoomGalleryRemoteDataSource galleryRemoteDataSource =
          RoomGalleryRemoteDataSourceImpl();

      galleryRemoteDataSource.getRoomGalleryData(
          RoomGalleryArgumentDomain(hotelId: '', roomId: ''), 1, 20);
    });

    test('room gallery remote data source test', () async {
      RoomGalleryRemoteDataSource galleryRemoteDataSource =
          RoomGalleryRemoteDataSourceImpl(
              graphQlResponse: _MockedRoomGalleryResponseImpl());
      galleryRemoteDataSource.getRoomGalleryData(
          RoomGalleryArgumentDomain(hotelId: '', roomId: ''), 1, 20);
    });
  });
}
