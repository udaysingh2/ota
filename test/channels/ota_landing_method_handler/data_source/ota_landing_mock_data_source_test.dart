import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_method_handler/data_source/ota_landing_handler_mock_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('OTA booking detail handler mock data source', () async {
    OtaLandingHandlerMockDataSourceImpl otaBookingHandlerMockDataSourceImpl =
        OtaLandingHandlerMockDataSourceImpl();
    otaBookingHandlerMockDataSourceImpl.handleMethodChannel(
        nativeResponse: (dat) {}, methodName: "methodName");
    otaBookingHandlerMockDataSourceImpl.dispose();
    OtaLandingHandlerMockDataSourceImpl.setMock(
        OtaLandingHandlerMockDataSourceImpl.getMockData());
  });
}
