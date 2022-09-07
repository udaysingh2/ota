import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("register Confirm Landing data source group", () {
    test('register Confirm Landing Data Source test', () async {
      RegisterConfirmLandingDataSource registerConfirmLandingDataSource =
          RegisterConfirmLandingDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = registerConfirmLandingDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "registerConfirmLanding");
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      RegisterConfirmLandingDataSourceImpl.setMock(otaChannel);
      registerConfirmLandingDataSource.dispose();
    });
    test('register Confirm Landing Data Source test with otaMethodChannel null',
        () async {
      RegisterConfirmLandingDataSource registerConfirmLandingDataSource =
          RegisterConfirmLandingDataSourceImpl(otaMethodChannel: null);
      // ignore: cancel_subscriptions
      registerConfirmLandingDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "registerConfirmLanding");
    });
  });
}
