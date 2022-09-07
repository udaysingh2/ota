import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';

void main() {
  test('hotel service data argument ...', () async {
    final hotelServiceDataArgument = HotelServiceDataArgument(
      hotelId: 'MA0711050518',
      checkInDate: '2021-10-24',
      checkOutDate: '2021-10-25',
      currency: 'TBH',
      limit: 20,
      offset: 0,
    );
    expect(hotelServiceDataArgument.hotelId.isNotEmpty, true);
    expect(hotelServiceDataArgument.checkInDate.isNotEmpty, true);
    expect(hotelServiceDataArgument.limit, 20);
  });

  test('hotel service data argument from HotelServiceViewArgument...',
      () async {
    final hotelServiceViewArgument = HotelServiceViewArgument(
      hotelId: 'MA0711050518',
      checkInDate: '2021-10-24',
      checkOutDate: '2021-10-25',
      currency: 'TBH',
      noOfAdults: 2,
      selectedAddons: [
        AddonServiceModel(selectedDate: DateTime.now(), serviceId: '279')
      ],
    );
    final hotelServiceDataArgument = HotelServiceDataArgument.fromViewArgument(
        hotelServiceViewArgument, 20, 0);
    expect(hotelServiceDataArgument.hotelId.isNotEmpty, true);
    expect(hotelServiceDataArgument.checkInDate.isNotEmpty, true);
    expect(hotelServiceDataArgument.limit, 20);
  });
}
