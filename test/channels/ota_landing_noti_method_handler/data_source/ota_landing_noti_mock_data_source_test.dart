import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/data_source/ota_landing_noti_handler_mock_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('OTA booking detail handler mock data source', () async {
    OtaLandingNotiHandlerMockDataSourceImpl
        otaBookingHandlerMockDataSourceImpl =
        OtaLandingNotiHandlerMockDataSourceImpl();
    otaBookingHandlerMockDataSourceImpl.handleMethodChannel(
        nativeResponse: (dat) {}, methodName: "methodName");
    otaBookingHandlerMockDataSourceImpl.dispose();
    OtaLandingNotiHandlerMockDataSourceImpl.setMock(
        OtaLandingNotiHandlerMockDataSourceImpl.getMockData());
  });
}
