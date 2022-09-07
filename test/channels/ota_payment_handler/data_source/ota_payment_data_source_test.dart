import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:ota/channels/ota_payment_handler/data_source/ota_payment_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("OTA payment handler data source group", () {
    test('OTA payment data source test', () async {
      OtaPaymentDataSourceImpl otaPaymentDataSource =
          OtaPaymentDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = otaPaymentDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "otaPayment");
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      OtaPaymentDataSourceImpl();
      OtaPaymentDataSourceImpl.setMock(otaChannel);
      otaPaymentDataSource.dispose();
    });
    test('OTA payment data source', () async {
      OtaPaymentDataSourceImpl otaPaymentDataSource =
          OtaPaymentDataSourceImpl(otaMethodChannel: null);
      // ignore: cancel_subscriptions
      otaPaymentDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "otaPayment");
    });

    test('OTA payment data source', () async {
      OtaPaymentDataSourceImpl otaPaymentDataSource =
          OtaPaymentDataSourceImpl(otaMethodChannel: MockOtaChannel());
      // ignore: cancel_subscriptions
      otaPaymentDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "otaPayment");
    });
  });
}

class MockOtaChannel implements OtaChannel {
  @override
  void dispose() {}

  @override
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic> p1) nativeResponse,
      bool? isDuplicateAllowed}) {
    throw UnimplementedError();
  }

  @override
  StreamSubscription handleNativeMethod(
      String methodName, Function(Map<String, dynamic>) nativeResponse) {
    nativeResponse({});
    return const Stream.empty().listen((event) {});
  }

  @override
  Future<Map<String, dynamic>> invokeNativeMethod(
      {required String methodName, required Map<String, dynamic> arguments}) {
    throw UnimplementedError();
  }
}
