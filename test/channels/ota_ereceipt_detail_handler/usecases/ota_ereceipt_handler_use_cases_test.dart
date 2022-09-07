import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/repositories/ota_ereceipt_handler_repository.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/usecases/ota_ereceipt_handler_use_cases.dart';

void main() {
  OtaEReceiptHandlerUseCase? otaEReceiptHandlerUseCase;
  setUpAll(() async {
    otaEReceiptHandlerUseCase = OtaEReceiptHandlerUseCaseImpl();
    otaEReceiptHandlerUseCase = OtaEReceiptHandlerUseCaseImpl(
        repository: OtaEReceiptHandlerRepositoryImpl());
  });

  test('OTA Landing Handler Use Cases test', () async {
    // ignore: cancel_subscriptions
    final consentResult = otaEReceiptHandlerUseCase!
        .handleMethodChannel(nativeResponse: (p0) {}, methodName: "");

    // ignore: unnecessary_null_comparison
    expect(consentResult != null, true);
    otaEReceiptHandlerUseCase!.dispose();
  });
}
