import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/models/landing_models.dart';
import 'package:ota/domain/landing/usecases/landing_page_usecases.dart';

import '../repositories/landing_page_impl_success_mock.dart';

void main() {
  LandingPageUseCases? landingPageUseCases;

  setUpAll(() async {
    /// Code coverage for default implementation.
    landingPageUseCases = LandingPageUseCasesImpl();

    /// Code coverage for mock class
    landingPageUseCases = LandingPageUseCasesImpl(
        repository: LandingPageRepositoryImplSuccessMock());
  });

  test(
      'landing Page analytics usecases '
      'When calling getlandingPageData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await landingPageUseCases!.getLandingPage();

    /// Get model from mock data.
    final LandingData? model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model?.getLandingPageDetails != null, true);
  });
}
