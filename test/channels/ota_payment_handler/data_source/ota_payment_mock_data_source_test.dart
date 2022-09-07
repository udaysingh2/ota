import 'package:flutter_test/flutter_test.dart';

import 'package:ota/channels/ota_payment_handler/data_source/ota_payment_mock_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('OTA payment handler mock data source', () async {
    OtaPaymentMockDataSourceImpl otaPaymentMockDataSource =
        OtaPaymentMockDataSourceImpl();
    otaPaymentMockDataSource.handleMethodChannel(
        nativeResponse: (dat) {}, methodName: "otaPayment");
    otaPaymentMockDataSource.dispose();
    OtaPaymentMockDataSourceImpl.setMock(
        OtaPaymentMockDataSourceImpl.getMockData());
  });
}
