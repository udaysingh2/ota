import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_mock_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  test('Hotel Static playlist Mock Test Success', () async {
    HotelStaticPlayListRemoteDataSource dataSource =
    HotelStaticPlayListMockDataSourceImpl();
    await dataSource.getHotelStaticPlayListData(getArgument());
  });
  test('Hotel Static playlist Mock Test source', () async {
    String actual = HotelStaticPlayListMockDataSourceImpl.getMockData();
    expect(actual.isNotEmpty, true);
  });
}

HotelStaticPlayListArgumentModelDomain getArgument() {
  return HotelStaticPlayListArgumentModelDomain(
    userId: '',
    lat: 0.0,
    long: 0.0,
    epoch: '',
  );
}
