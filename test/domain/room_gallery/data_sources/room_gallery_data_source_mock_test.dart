import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_data_source_mock.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  test('For class RoomGalleryMockDataSourceImpl ==> getRoomGalleryData Test',
      () async {
    RoomGalleryRemoteDataSource dataSource = RoomGalleryMockDataSourceImpl();

    final result = await dataSource.getRoomGalleryData(args(), 1, 10);

    expect(result, isA<RoomGalleryModelDomain>());
  });

  test('For class RoomGalleryMockDataSourceImpl ==> getMockData Test', () {
    final actual = RoomGalleryMockDataSourceImpl.getMockData();

    expect(actual.isNotEmpty, true);
  });
}

RoomGalleryArgumentDomain args() => RoomGalleryArgumentDomain(
      hotelId: 'hotelId',
      roomId: 'roomId',
    );
