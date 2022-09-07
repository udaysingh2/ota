import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Hotel Service Data argument group", () {
    test('Hotel Service Data argument model', () async {
      HotelServiceDataArgument hotelServiceDataArgument =
          HotelServiceDataArgument.fromViewArgument(
              HotelServiceViewArgument(
                  currency: 'th',
                  checkInDate: '11',
                  selectedAddons: [],
                  hotelId: 'id',
                  checkOutDate: '12',
                  noOfAdults: 2),
              10,
              0);
      expect(hotelServiceDataArgument.currency, "th");
    });
  });
}
