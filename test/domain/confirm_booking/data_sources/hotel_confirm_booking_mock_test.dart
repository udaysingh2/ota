import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_mock.dart';
import 'package:ota/domain/confirm_booking/data_sources/hotel_confirm_booking_remote_data_source.dart';
import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';

void main() {
  HotelConfirmBookingArgumentModelDomain argument =
      HotelConfirmBookingArgumentModelDomain(
    customerInfo: CustomerInfoDataDomain(
        firstName: 'TestFirstName',
        lastName: 'TestLastName',
        membershipId: 'TestMembershipId'),
    totalPrice: 1000.0,
    roomCode: '',
    bookingForSomeoneElse: false,
    bookingUrn: '',
    additionalNeedsText: '',
    hotelId: '',
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Hotel Confirm Booking mock data source group", () {
    test('Hotel Confirm Booking data source', () async {
      HotelConfirmBookingRemoteDataSource hotelConfirmBookingRemoteDataSource =
          HotelConfirmBookingMockDataSourceImpl();
      hotelConfirmBookingRemoteDataSource.getHotelConfirmBooking(argument);
    });
    test(
        'Hotel Confirm Booking Repository '
        'With Success response data', () async {
      /// Consent user cases impl
      HotelConfirmBookingRemoteDataSource hotelConfirmBookingRemoteDataSource =
          HotelConfirmBookingMockDataSourceImpl();
      final result = await hotelConfirmBookingRemoteDataSource
          .getHotelConfirmBooking(argument);

      /// Condition check for booking confirm data null
      expect(result.data != null, true);
    });
  });
}
