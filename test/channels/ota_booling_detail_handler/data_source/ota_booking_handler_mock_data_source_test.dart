import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_booling_detail_handler/data_source/ota_booking_handler_mock_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('OTA booking detail handler mock data source', () async {
    OtaBookingHandlerMockDataSourceImpl otaBookingHandlerMockDataSourceImpl =
        OtaBookingHandlerMockDataSourceImpl();
    otaBookingHandlerMockDataSourceImpl.handleMethodChannel(
        nativeResponse: (dat) {}, methodName: "methodName");
    otaBookingHandlerMockDataSourceImpl.dispose();
    OtaBookingHandlerMockDataSourceImpl.setMock(
        OtaBookingHandlerMockDataSourceImpl.getMockData());
  });
}
