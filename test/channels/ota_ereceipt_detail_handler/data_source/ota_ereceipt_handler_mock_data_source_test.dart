import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_data_source.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_mock_data_source.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json =
      fixture("channels/ota_ereceipt_handler/ota_ereceipt_handler.json");

  test('OTA e receipt handler mock data source', () async {
    OtaEReceiptHandlerDataSource otaEReceiptHandlerDataSource =
        OtaEReceiptHandlerMockDataSourceImpl();

    // ignore: cancel_subscriptions
    final res = otaEReceiptHandlerDataSource.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "hotelDetail");
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    OtaEReceiptHandlerMockDataSourceImpl.getMockData();
    OtaEReceiptHandlerMockDataSourceImpl.setMock(json);
    otaEReceiptHandlerDataSource.dispose();
  });
}
