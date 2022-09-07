import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/register_confirm_landing_handler/repositories/register_confirm_landing_repository_impl.dart';
import 'package:ota/channels/register_confirm_landing_handler/usecases/register_confirm_landing_use_cases.dart';

void main() {
  RegisterConfirmLandingUseCases? registerConfirmLandingUseCases;
  setUpAll(() async {
    registerConfirmLandingUseCases = RegisterConfirmLandingUseCasesImpl();
    registerConfirmLandingUseCases = RegisterConfirmLandingUseCasesImpl(
        repository: RegisterConfirmLandingRepositoryImpl());
  });

  test('Register Confirm Landing Use Cases test', () async {
    // ignore: cancel_subscriptions
    final consentResult = registerConfirmLandingUseCases!.handleMethodChannel(
        nativeResponse: (p0) {}, methodName: "registerConfirmLanding");
    // ignore: unnecessary_null_comparison
    expect(consentResult != null, true);
    registerConfirmLandingUseCases!.dispose();
  });
}
