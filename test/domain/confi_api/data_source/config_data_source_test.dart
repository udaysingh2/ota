import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/confi_api/data_sources/config_remote_data_source.dart';
import 'package:ota/domain/confi_api/repositories/config_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/config_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponseConfig = MockConfigGraphQl();
  ConfigRemoteDataSourceImpl.setMock(graphQlResponseConfig);
  ConfigRepository configRepository = ConfigRepositoryImpl(
      remoteDataSource: ConfigRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Config Data Source", () {
    ConfigRemoteDataSource configRemoteDataSource =
        ConfigRemoteDataSourceImpl();
    ConfigRemoteDataSourceImpl.setMock(graphQlResponseConfig);
    configRemoteDataSource.getConfigDetails();
  });
  test(
      'Config analytics Repository '
      'When calling getConfigDetails '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await configRepository.getConfigDetails();

    expect(consentResult.isRight, true);
  });
}
