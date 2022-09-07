import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_booking_handler/repositories/register_confirm_booking_repository.dart';
import 'package:ota/channels/register_confirm_booking_handler/usecases/register_confirm_booking_use_cases.dart';

void main() {
  RegisterConfirmBookingUseCases? registerConfirmBookingUseCases;
  setUpAll(() async {
    registerConfirmBookingUseCases = RegisterConfirmBookingUseCasesImpl();
    registerConfirmBookingUseCases = RegisterConfirmBookingUseCasesImpl(
        repository: RegisterConfirmBookingRepositoryImpl());
  });

  test('Register Confirm Booking Use Cases test', () async {
    // ignore: cancel_subscriptions
    final consentResult = registerConfirmBookingUseCases!.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "registerConfirmBooking");
    // ignore: unnecessary_null_comparison
    expect(consentResult != null, true);
    registerConfirmBookingUseCases!.dispose();
  });
}
