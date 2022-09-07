import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_data_source.dart';
import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_mock_data_source.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final String json = fixture(
      "channels/register_confirm_landing_handler/register_confirm_landing_handler.json");

  test('Register Confirm Landing mock data source', () async {
    RegisterConfirmLandingDataSource registerConfirmLandingDataSource =
        RegisterConfirmLandingMockDataSourceImpl();
    // ignore: cancel_subscriptions
    final res = registerConfirmLandingDataSource.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "registerConfirmLanding");
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    RegisterConfirmLandingMockDataSourceImpl.getMockData();
    RegisterConfirmLandingMockDataSourceImpl.setMock(json);
    registerConfirmLandingDataSource.dispose();
  });
}
