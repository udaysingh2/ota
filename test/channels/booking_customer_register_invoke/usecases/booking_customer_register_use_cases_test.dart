import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/repositories/booking_customer_register_repository.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';

void main() {
  BookingCustomerRegisterUseCases? bookingCustomerRegisterUseCases;
  setUpAll(() async {
    bookingCustomerRegisterUseCases = BookingCustomerRegisterUseCasesImpl();
    bookingCustomerRegisterUseCases = BookingCustomerRegisterUseCasesImpl(
        repository: BookingCustomerRegisterRepositoryImpl());
  });

  test('OTA booking customer register Use Cases test', () async {
    final consentResult = bookingCustomerRegisterUseCases!.invokeExampleMethod(
        arguments: BookingCustomerRegisterArgumentModelChannel(
            userType: "", userId: "", language: "", env: ""),
        methodName: "");

    // ignore: unnecessary_null_comparison
    expect(consentResult != null, true);
    bookingCustomerRegisterUseCases!.dispose();
  });
}
