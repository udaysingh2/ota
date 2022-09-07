import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/repositories/loading_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/loading_mock_data_source.dart';

const _serviceName = "CARRENTAL";

void main() {
  GraphQlResponse graphQlResponseLoading = MockLoadingGraphQl();
  LoadingRemoteDataSourceImpl.setMock(graphQlResponseLoading);
  LoadingRepository loadingRepository = LoadingRepositoryImpl(
      remoteDataSource: LoadingRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  SharedPreferences.setMockInitialValues({"kLoadingJsonData": ""});
  test("Loading Page Data Source", () {
    LoadingRemoteDataSource loadingRemoteDataSource =
        LoadingRemoteDataSourceImpl();
    LoadingRemoteDataSourceImpl.setMock(graphQlResponseLoading);
    loadingRemoteDataSource.getLoadingData(_serviceName);
  });
  test(
      'Loading Page analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await loadingRepository.getLoadingData(_serviceName);

    expect(consentResult.isRight, true);
  });
}
