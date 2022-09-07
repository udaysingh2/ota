// ignore_for_file: cancel_subscriptions

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("OTA e receipt  handler data source group", () {
    test('OTA  e receipt  handler data source', () async {
      OtaEReceiptHandlerDataSource otaEReceiptHandlerDataSource =
          OtaEReceiptHandlerDataSourceImpl(otaMethodChannel: otaChannel);

      final res = otaEReceiptHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "hotelDetail");
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      OtaEReceiptHandlerDataSourceImpl.setMock(otaChannel);
      otaEReceiptHandlerDataSource.dispose();
    });
    // ignore: duplicate_ignore
    test('hotel  e receipt  handler data source', () async {
      OtaEReceiptHandlerDataSource otaEReceiptHandlerDataSource =
          OtaEReceiptHandlerDataSourceImpl(otaMethodChannel: null);
      otaEReceiptHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "hotelDetail");
    });
  });
}
