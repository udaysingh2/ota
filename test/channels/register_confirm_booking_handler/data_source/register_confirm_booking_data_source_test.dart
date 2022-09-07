import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("register Confirm Booking data source group", () {
    test('register Confirm Booking Data Source test', () async {
      RegisterConfirmBookingDataSource registerConfirmBookingDataSource =
          RegisterConfirmBookingDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = registerConfirmBookingDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "registerConfirmBooking");
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      RegisterConfirmBookingDataSourceImpl.setMock(otaChannel);
      registerConfirmBookingDataSource.dispose();
    });
    test('register Confirm Booking Data Source test with otaMethodChannel null',
        () async {
      RegisterConfirmBookingDataSource registerConfirmBookingDataSource =
          RegisterConfirmBookingDataSourceImpl(otaMethodChannel: null);
      // ignore: cancel_subscriptions
      registerConfirmBookingDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "registerConfirmBooking");
    });
  });
}
