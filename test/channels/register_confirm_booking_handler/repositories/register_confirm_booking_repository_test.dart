import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_mock_data_source.dart';

import 'package:ota/channels/register_confirm_booking_handler/repositories/register_confirm_booking_repository.dart';

void main() {
  RegisterConfirmBookingRepository? registerConfirmBookingRepository;

  setUpAll(() async {
    registerConfirmBookingRepository = RegisterConfirmBookingRepositoryImpl();

    registerConfirmBookingRepository = RegisterConfirmBookingRepositoryImpl(
      remoteDataSource: RegisterConfirmBookingMockDataSourceImpl(),
    );
  });

  test('Register Confirm Booking Repository test', () async {
    // ignore: await_only_futures
    final res = await registerConfirmBookingRepository!.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "registerConfirmBooking");
    registerConfirmBookingRepository!.dispose();
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
  });
}
