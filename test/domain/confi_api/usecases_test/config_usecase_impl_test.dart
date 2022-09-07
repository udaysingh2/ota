import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/domain/confi_api/usecases/config_use_cases.dart';
import '../repositories/config_repository_impl_success_mock.dart';

void main() {
  ConfigUseCases? configUseCases;
  setUpAll(() async {
    /// Code coverage for default implementation.
    configUseCases = ConfigUseCasesImpl();

    /// Code coverage for mock class
    configUseCases =
        ConfigUseCasesImpl(repository: ConfigRepositoryImplSuccessMock());
  });

  test(
      'Config analytics usecases '
      'When calling getConfigDetails '
      'With Success response data', () async {
    /// Consent user cases impl
    final configResult = await configUseCases!.getConfigDetails();

    /// Get model from mock data.
    final ConfigResultModel model = configResult!.right;

    /// Condition check for config value null
    expect(model.getConfigDetails != null, true);
  });
}
