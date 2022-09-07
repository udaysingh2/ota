import 'package:flutter_test/flutter_test.dart';

import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_data_source.dart';
import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_mock_data_source.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture(
      "channels/register_confirm_booking_handler/register_confirm_booking_handler.json");

  test('Register Confirm Booking mock data source', () async {
    RegisterConfirmBookingDataSource registerConfirmBookingDataSource =
        RegisterConfirmBookingMockDataSourceImpl();
    // ignore: cancel_subscriptions
    final res = registerConfirmBookingDataSource.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "registerConfirmBooking");
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    RegisterConfirmBookingMockDataSourceImpl.getMockData();
    RegisterConfirmBookingMockDataSourceImpl.setMock(json);
    registerConfirmBookingDataSource.dispose();
  });
}
