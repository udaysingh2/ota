// ignore_for_file: cancel_subscriptions, unnecessary_null_comparison

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_confirm_payment_handler/data_sources/booking_confirm_handler_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("OTA booking confirm data source group", () {
    test('OTA booking confirm  data source', () async {
      BookingConfirmHandlerDataSource bookingConfirmHandlerDataSource =
          BookingConfirmHandlerDataSourceImpl(otaMethodChannel: otaChannel);
      final res = bookingConfirmHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "hotelDetail");
      expect(res != null, true);
      BookingConfirmHandlerDataSourceImpl.setMock(otaChannel);
      bookingConfirmHandlerDataSource.dispose();
    });
    test('hotel booking confirm data source', () async {
      BookingConfirmHandlerDataSource bookingConfirmHandlerDataSource =
          BookingConfirmHandlerDataSourceImpl(otaMethodChannel: null);
      bookingConfirmHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "hotelDetail");
    });
  });
}
