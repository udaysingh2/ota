import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("Log Crashlytics Data Source group", () {
    const MethodChannel channel =
        MethodChannel('robinhood.flutter.ota/methodChannelName');
    channel.setMockMethodCallHandler((call) async {
      return "{}";
    });
    test('Log Crashlytics Data Source test', () async {
      LogCrashlyticsDataSource logCrashlyticsDataSource =
          PaymentManagementDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = logCrashlyticsDataSource.invokeMethod(
          methodName: "",
          arguments: LogCrashlyticsArgumentModelChannel(
              className: "", message: "", stackTrace: ""));
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      PaymentManagementDataSourceImpl.setMock(otaChannel);
      logCrashlyticsDataSource.dispose();
    });
  });
}
