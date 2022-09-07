import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_mock_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';

const String _kServiceTypeHotel = 'HOTEL';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Recommended Locations Mock Test", () {
    test('Hotel Recommended Locations Mock Test Success', () async {
      RecommendedLocationRemoteDataSource recommendedLocationRemoteDataSource =
          RecommendedLocationMockDataSourceImpl();
      recommendedLocationRemoteDataSource
          .getRecommendedLocationData(_kServiceTypeHotel);
    });
    test('Recommended Locations Mock Test source', () async {
      String response = RecommendedLocationMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
  });
}
