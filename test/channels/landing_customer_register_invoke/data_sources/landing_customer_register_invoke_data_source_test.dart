import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("Landing Customer Register Data Source group", () {
    test('Landing Customer Register Data Source test', () async {
      const MethodChannel('robinhood.flutter.ota/methodChannelName')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        printDebug({methodCall.method});
        return "{}";
        // set initial values here if desired
      });
      LandingCustomerRegisterDataSource landingCustomerRegisterDataSource =
          LandingCustomerRegisterDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = landingCustomerRegisterDataSource.invokeExampleMethod(
          methodName: "LandingCustomerRegister",
          arguments: LandingCustomerRegisterArgumentModelChannel(
              env: "env",
              language: "language",
              userId: "userId",
              userType: "userType"));
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
    });
  });
}
