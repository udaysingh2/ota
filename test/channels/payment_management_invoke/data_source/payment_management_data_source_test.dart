import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_data_source.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("Payment management invoke Data Source group", () {
    test('Payment management Data Source test', () async {
      const MethodChannel('robinhood.flutter.ota/methodChannelName')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        return "{}";
        // set initial values here if desired
      });
      PaymentManagementDataSource paymentManagementDataSource =
          PaymentManagementDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = paymentManagementDataSource.invokeExampleMethod(
          methodName: "paymentManagement",
          arguments: PaymentManagementArgumentModelChannel(
              env: "env",
              language: "language",
              userId: "userId",
              serviceType: "serviceType"));
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
    });
  });
}
