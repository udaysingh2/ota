import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_mock_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/repositories/booking_customer_register_repository.dart';

void main() {
  BookingCustomerRegisterRepository? bookingCustomerRegisterRepository;

  setUpAll(() async {
    bookingCustomerRegisterRepository = BookingCustomerRegisterRepositoryImpl();
    bookingCustomerRegisterRepository = BookingCustomerRegisterRepositoryImpl(
        remoteDataSource: BookingCustomerRegisterMockDataSourceImpl());
  });

  test('Prefrence pop up repo with Success response data', () async {
    final res = await bookingCustomerRegisterRepository!.invokeExampleMethod(
        methodName: "methodName",
        arguments: BookingCustomerRegisterArgumentModelChannel(
            userType: "", userId: "", language: "", env: ""));

    bookingCustomerRegisterRepository?.dispose();

    // ignore: unnecessary_null_comparison
    expect(res != null, true);
  });
}
