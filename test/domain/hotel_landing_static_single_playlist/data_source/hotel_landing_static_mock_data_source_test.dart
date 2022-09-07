import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_data_source_mock.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';

void main() {
  HotelLandingStaticSingleDataArgument argument =
      HotelLandingStaticSingleDataArgument(
          playlistId: "playlistId", userId: "userId");

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Hotel landing static playlist mock data source group", () {
    test('Hotel landing static playlist mock data source test', () async {
      HotelLandingStaticDataSource hotelLandingStaticDataSource =
          HotelLandingStaticMockDataSourceImpl();
      hotelLandingStaticDataSource.getPlaylist(argument);
    });
    test('Hotel landing static playlist mock data source test', () async {
      String response = HotelLandingStaticMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
  });
}
