// ignore_for_file: cancel_subscriptions

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/booking_confirm_payment_handler/data_sources/booking_confirm_handler_data_source.dart';
import 'package:ota/channels/booking_confirm_payment_handler/data_sources/booking_confirm_handler_mock_data_source.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture(
      "channels/booking_confirm_payment_handler/booking_confirm_payment_handler.json");

  test('OTA booking confirm payment mock data source', () async {
    BookingConfirmHandlerDataSource bookingConfirmHandlerDataSource =
        BookingConfirmHandlerMockDataSourceImpl();
    final res = bookingConfirmHandlerDataSource.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "hotelDetail");
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    BookingConfirmHandlerMockDataSourceImpl.getMockData();
    BookingConfirmHandlerMockDataSourceImpl.setMock(json);
    bookingConfirmHandlerDataSource.dispose();
  });
}
