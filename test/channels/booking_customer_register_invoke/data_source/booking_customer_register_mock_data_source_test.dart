import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_mock_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('OTA booking detail handler mock data source', () async {
    BookingCustomerRegisterDataSource bookingCustomerRegisterDataSource =
        BookingCustomerRegisterMockDataSourceImpl();
    // ignore: cancel_subscriptions
    final res = bookingCustomerRegisterDataSource.invokeExampleMethod(
        methodName: "methodName",
        arguments: BookingCustomerRegisterArgumentModelChannel(
            env: "", language: "", userId: "", userType: ""));
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    bookingCustomerRegisterDataSource.dispose();
  });
}
