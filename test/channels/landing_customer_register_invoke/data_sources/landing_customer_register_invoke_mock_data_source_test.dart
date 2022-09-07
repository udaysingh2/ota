import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_mock_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Landing Customer Register  mock data source test', () async {
    LandingCustomerRegisterDataSource landingCustomerRegisterDataSource =
        LandingCustomerRegisterMockDataSourceImpl();
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
    landingCustomerRegisterDataSource.dispose();
  });
}
