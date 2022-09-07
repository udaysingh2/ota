// ignore_for_file: cancel_subscriptions

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_confirm_payment_handler/repositories/booking_confirm_handler_repository.dart';
import 'package:ota/channels/booking_confirm_payment_handler/usecases/booking_confirm_handler_use_cases.dart';

void main() {
  BookingConfirmHandlerUseCase? bookingConfirmHandlerUseCase;
  setUpAll(() async {
    bookingConfirmHandlerUseCase = BookingConfirmHandlerUseCaseImpl();
    bookingConfirmHandlerUseCase = BookingConfirmHandlerUseCaseImpl(
        repository: BookingConfirmHandlerRepositoryImpl());
  });

  test('OTA booking confirm  Handler Use Cases test', () async {
    final consentResult = bookingConfirmHandlerUseCase!
        .handleMethodChannel(nativeResponse: (p0) {}, methodName: "");

    // ignore: unnecessary_null_comparison
    expect(consentResult != null, true);

    bookingConfirmHandlerUseCase!.dispose();
  });
}
