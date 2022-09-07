import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import 'package:ota/domain/confi_api/repositories/config_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/config_remote_datasource_impl_failure_mock.dart';
import '../repositories/config_remote_datasource_impl_moc.dart';

void main() {
  ConfigRepository? configRepositoryServerException;
  ConfigRepository? configRepositoryMock;
  ConfigRepository? configRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    configRepositoryMock = ConfigRepositoryImpl();

    /// Code coverage for mock class
    configRepositoryMock = ConfigRepositoryImpl(
        remoteDataSource: ConfigRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    configRepositoryServerException = ConfigRepositoryImpl(
        remoteDataSource: ConfigRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    configRepositoryInternetFailure = ConfigRepositoryImpl(
        remoteDataSource: ConfigRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Config analytics Repository '
      'When calling getConfigDetails '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await configRepositoryMock!.getConfigDetails();

    /// Get model from mock data.
    final ConfigResultModel model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getConfigDetails != null, true);
  });

  test(
      'Config analytics Repository '
      'When calling getConfigDetails '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult =
        await configRepositoryInternetFailure!.getConfigDetails();

    expect(consentResult.isLeft, true);
  });

  test(
      'Config analytics Repository '
      'When calling getConfigDetails '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final configResult =
        await configRepositoryServerException!.getConfigDetails();

    expect(configResult.isLeft, true);
  });
}
