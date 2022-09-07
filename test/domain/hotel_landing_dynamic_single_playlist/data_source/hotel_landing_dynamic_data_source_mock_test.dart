import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_data_source_mock.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';

void main() {
  HotelLandingDynamicSingleDataArgument argument =
      HotelLandingDynamicSingleDataArgument(
          playlistId: "playlistId", userId: "userId");

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Hotel landing dynamic playlist mock data source group", () {
    test('Hotel landing dynamic playlist mock data source test', () async {
      HotelLandingDynamicDataSource hotelLandingDynamicDataSource =
          HotelLandingDynamicMockDataSourceImpl();
      hotelLandingDynamicDataSource.getPlaylist(argument);
    });
    test('Hotel landing dynamic playlist mock data source test', () async {
      String response = HotelLandingDynamicMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
  });
}
