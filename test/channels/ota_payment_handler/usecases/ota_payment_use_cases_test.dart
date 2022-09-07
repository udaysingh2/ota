import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/channels/ota_payment_handler/repositories/ota_payment_repository.dart';
import 'package:ota/channels/ota_payment_handler/usecases/ota_payment_use_cases.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA payment handler use cases group", () {
    test('OTA payment handler use cases test ', () async {
      OtaPaymentUseCasesImpl otaPaymentUseCasesImpl =
          OtaPaymentUseCasesImpl(repository: GetPaymentRepositoryMock());
      otaPaymentUseCasesImpl.handleMethodChannel(
          methodName: "otaPayment", nativeResponse: (p1) {});
      otaPaymentUseCasesImpl.dispose();
      OtaPaymentUseCasesImpl();
    });
  });
}

class GetPaymentRepositoryMock implements OtaPaymentRepository {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaPaymentModelChannel model) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
