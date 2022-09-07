import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/usecases/loading_usecases.dart';

import '../repositories/loading_screen_repository_impl_success_mock.dart';

const _serviceName = "CARRENTAL";

void main() {
  LoadingUseCases? loadingUseCases;

  setUpAll(() async {
    /// Code coverage for default implementation.
    loadingUseCases = LoadingUseCasesImpl();

    /// Code coverage for mock class
    loadingUseCases =
        LoadingUseCasesImpl(repository: LoadingRepositoryImplSuccessMock());
  });

  test(
      'landing Page analytics usecases '
      'When calling getloadingData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await loadingUseCases!.getLoadingData(_serviceName);

    /// Get model from mock data.
    final LoadingModelData model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model.getLoadScreen != null, true);
  });
}
