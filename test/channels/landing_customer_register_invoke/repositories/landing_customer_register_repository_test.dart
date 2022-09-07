import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_mock_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/channels/landing_customer_register_invoke/repositories/landing_customer_register_repository.dart';

void main() {
  LandingCustomerRegisterRepository? landingCustomerRegisterRepository;

  setUpAll(() async {
    landingCustomerRegisterRepository = LandingCustomerRegisterRepositoryImpl();

    landingCustomerRegisterRepository = LandingCustomerRegisterRepositoryImpl(
      remoteDataSource: LandingCustomerRegisterMockDataSourceImpl(),
    );
  });

  test('Landing Customer Register Repository test', () async {
    final res = await landingCustomerRegisterRepository!.invokeExampleMethod(
        methodName: "LandingCustomerRegister",
        arguments: LandingCustomerRegisterArgumentModelChannel(
            env: "env", language: "language"));
    landingCustomerRegisterRepository!.dispose();
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
  });
}
