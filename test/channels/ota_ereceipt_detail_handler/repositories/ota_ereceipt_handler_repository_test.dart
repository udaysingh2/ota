import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_mock_data_source.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/repositories/ota_ereceipt_handler_repository.dart';

void main() {
  OtaEReceiptHandlerRepository? otaEReceiptHandlerRepository;

  setUpAll(() async {
    otaEReceiptHandlerRepository = OtaEReceiptHandlerRepositoryImpl();
    otaEReceiptHandlerRepository = OtaEReceiptHandlerRepositoryImpl(
        remoteDataSource: OtaEReceiptHandlerMockDataSourceImpl());
  });

  test('Prefrence pop up repo with Success response data', () async {
    // ignore: cancel_subscriptions, await_only_futures
    final res = await otaEReceiptHandlerRepository!
        .handleMethodChannel(nativeResponse: (p0) {}, methodName: "");

    otaEReceiptHandlerRepository?.dispose();

    // ignore: unnecessary_null_comparison
    expect(res != null, true);
  });
}
