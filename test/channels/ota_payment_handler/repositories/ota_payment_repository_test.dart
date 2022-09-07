import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_payment_handler/data_source/ota_payment_data_source.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/channels/ota_payment_handler/repositories/ota_payment_repository.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("OTA payment handler repository group", () {
    test('OTA payment handler repository test', () async {
      OtaPaymentRepositoryImpl otaPaymentRepositoryImpl =
          OtaPaymentRepositoryImpl(
              remoteDataSource: GetPaymentMockDataSource());
      otaPaymentRepositoryImpl.handleMethodChannel(
          nativeResponse: (pt) {}, methodName: "otaPayment");

      otaPaymentRepositoryImpl.dispose();
      OtaPaymentRepositoryImpl();
      OtaChannelConfig.isModule = true;
      OtaPaymentRepositoryImpl();
    });
  });
}

class GetPaymentMockDataSource implements OtaPaymentDataSource {
  @override
  void dispose() {}

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaPaymentModelChannel model) nativeResponse,
      required String methodName}) {
    return const Stream.empty().listen((event) {});
  }
}
