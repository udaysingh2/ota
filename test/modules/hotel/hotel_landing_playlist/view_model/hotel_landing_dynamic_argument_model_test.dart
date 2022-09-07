import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_dynamic_argument_model.dart';

void main() {
  test(
    'Hotel Landing Dynamic Argument Tests',
    () async {
      HotelLandingDynamicArgumentModel hotelLandingDataArgument =
          HotelLandingDynamicArgumentModel(
        userId: '1',
        epoch: '1001',
        lat: 0.0,
        playlistId: '',
      );

      expect(hotelLandingDataArgument.userId, '1');
      expect(hotelLandingDataArgument.epoch, '1001');
      expect(hotelLandingDataArgument.lat, 0.0);
      expect(hotelLandingDataArgument.playlistId, '');
    },
  );
}
