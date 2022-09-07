import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_static_argument_model.dart';

HotelLandingStaticArgumentModel getHotelLandingStaicViewArgumentMock() {
  return HotelLandingStaticArgumentModel(
    userId: '1',
    epoch: '1001',
    lat: 0.0,
    lng: 0.0,
    serviceName: 'hotels',
    playlistId: '32',
    playlistName: 'Recommeneded',
  );
}
