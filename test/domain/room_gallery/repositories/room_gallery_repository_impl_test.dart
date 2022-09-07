import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/room_gallery/repositories/room_gallery_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Room Gallery repository test', () {
    test('Room Gallery repo test for internet success', () async {
      RoomGalleryRepositoryImpl();
      RoomGalleryRepository repository = RoomGalleryRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedRoomGalleryDataSource(),
      );

      repository.getRoomGalleryData(
          RoomGalleryArgumentDomain(hotelId: '', roomId: ''), 1, 20);
    });

    test('Room Gallery repo test for internet failure', () async {
      RoomGalleryRepositoryImpl();
      RoomGalleryRepository repository = RoomGalleryRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedRoomGalleryDataSource(),
      );

      repository.getRoomGalleryData(
          RoomGalleryArgumentDomain(hotelId: '', roomId: ''), 1, 20);
    });

    test('Room Gallery repo test for exception', () async {
      RoomGalleryRepositoryImpl();
      RoomGalleryRepository repository = RoomGalleryRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedRoomGalleryDataSource(),
      );
      try {
        await repository.getRoomGalleryData(
            RoomGalleryArgumentDomain(hotelId: '', roomId: ''), 1, 20);
      } catch (error) {
        return (error);
      }
    });
  });
}

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class MockedRoomGalleryDataSource extends RoomGalleryRemoteDataSource {
  @override
  Future<RoomGalleryModelDomain> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) {
    Map<String, dynamic> map =
        json.decode(fixture("room_gallery/room_gallery_mock.json"));

    return Future.value(RoomGalleryModelDomain.fromMap(map));
  }
}

class MockedRoomGalleryDataSourceException
    implements RoomGalleryRemoteDataSource {
  @override
  Future<RoomGalleryModelDomain> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) {
    throw Future.value(Exception());
  }
}
