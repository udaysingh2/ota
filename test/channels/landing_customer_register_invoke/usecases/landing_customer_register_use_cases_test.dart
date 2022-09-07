import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/channels/landing_customer_register_invoke/repositories/landing_customer_register_repository.dart';
import 'package:ota/channels/landing_customer_register_invoke/usecases/landing_customer_register_use_cases.dart';

void main() {
  LandingCustomerRegisterUseCases? landingCustomerRegisterUseCases;
  setUpAll(() async {
    landingCustomerRegisterUseCases = LandingCustomerRegisterUseCasesImpl();
    landingCustomerRegisterUseCases = LandingCustomerRegisterUseCasesImpl(
        repository: LandingCustomerRegisterRepositoryImpl());
  });

  test('Landing Customer Register Use Cases test', () async {
    // ignore: cancel_subscriptions
    final res = landingCustomerRegisterUseCases!.invokeExampleMethod(
        methodName: "landingCustomerRegister",
        arguments: LandingCustomerRegisterArgumentModelChannel(
            env: "env", language: "language"));

    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    landingCustomerRegisterUseCases!.dispose();
  });
}
