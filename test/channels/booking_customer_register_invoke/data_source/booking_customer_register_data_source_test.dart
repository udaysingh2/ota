// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("OTA booking customer data source group", () {
    const MethodChannel channel =
        MethodChannel('robinhood.flutter.ota/methodChannelName');
    channel.setMockMethodCallHandler((call) async {
      return "{}";
    });
    test('OTA booking customer  data source', () async {
      BookingCustomerRegisterDataSource bookingCustomerRegisterDataSource =
          BookingCustomerRegisterDataSourceImpl(otaMethodChannel: otaChannel);
      final resource = bookingCustomerRegisterDataSource;

      expect(resource != null, true);
      BookingCustomerRegisterDataSourceImpl.setMock(otaChannel);
      bookingCustomerRegisterDataSource.dispose();
    });
    test('hotel booking customer data source', () async {
      BookingCustomerRegisterDataSource bookingCustomerRegisterDataSource =
          BookingCustomerRegisterDataSourceImpl(otaMethodChannel: otaChannel);

      bookingCustomerRegisterDataSource.invokeExampleMethod(
          methodName: "methodName",
          arguments: BookingCustomerRegisterArgumentModelChannel(
              env: "alpha", language: 'EN', userId: '2', userType: 'GUEST'));
    });
  });
}
