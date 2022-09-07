import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_mock.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

void main() {
  CarBookingCancellationArgument argument =
      CarBookingCancellationArgument(confirmNo: '', reason: 'Testing');

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car Booking Cancellation Mock Data source group", () {
    test("Car Booking Cancellation Data Source", () async {
      CarBookingCancellationRemoteDataSource
          carBookingCancellationRemoteDataSource =
          CarBookingCancellationMockDataSourceImpl();
      carBookingCancellationRemoteDataSource
          .getCarBookingCancellationData(argument);
    });
    test("Car Booking Cancellation with Suceess response data", () async {
      CarBookingCancellationRemoteDataSource
          carBookingCancellationRemoteDataSource =
          CarBookingCancellationMockDataSourceImpl();
      final result = await carBookingCancellationRemoteDataSource
          .getCarBookingCancellationData(argument);
      expect(result.data != null, true);
    });
  });
}
