import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_booking_argument_model.dart';

void main() {
  test('argument model - default argument...', () async {
    final hotelDetailArgument = HotelBookingsArgumentModel(bookingType: 1);
    expect(hotelDetailArgument.bookingType, 1);

    final hotelDetailArgument1 = HotelBookingsArgumentModel(bookingType: null);
    expect(hotelDetailArgument1.bookingType, null);
  });
}
