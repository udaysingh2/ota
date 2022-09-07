import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_mock.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/data_source/hotel_booking_cancellation_remote_data_source.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

void main() {
  HotelBookingCancellationArgument argument =
      HotelBookingCancellationArgument(confirmNo: '', reason: 'Testing file');

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Hotel Booking Cancellation mock data source group", () {
    test('Hotel Booking Cancellation data source', () async {
      HotelBookingCancellationRemoteDataSource
          hotelBookingCancellationRemoteDataSource =
          HotelBookingCancellationMockDataSourceImpl();
      hotelBookingCancellationRemoteDataSource
          .getHotelBookingCancellationData(argument);
    });
    test(
        'Hotel Booking Cancellation Repository '
        'With Success response data', () async {
      /// Consent user cases impl
      HotelBookingCancellationRemoteDataSource
          hotelBookingCancellationRemoteDataSource =
          HotelBookingCancellationMockDataSourceImpl();
      final result = await hotelBookingCancellationRemoteDataSource
          .getHotelBookingCancellationData(argument);

      /// Condition check for reject booking value null
      expect(result.data != null, true);
    });
  });
}
