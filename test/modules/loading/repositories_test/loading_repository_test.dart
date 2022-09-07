import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/loading/data_sources/loading_mock_data_source.dart';
import 'package:ota/domain/loading/data_sources/loading_remote_data_source.dart';
import 'package:ota/domain/loading/data_sources/loading_shared_data_source.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/repositories/loading_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/loading_screen_remote_datasource_impl_failure_mock.dart';

const _serviceName = "CARRENTAL";

void main() {
  LoadingRepository? loadingRepositoryServerException;
  LoadingRepository? loadingRepositoryMock;
  LoadingRepository? loadingRepositoryInternetFailure;
  LoadingRepository? loadingSharedRepositoryMock;

  setUpAll(() async {
    /// Code coverage for default implementation.
    loadingRepositoryMock = LoadingRepositoryImpl();

    /// Code coverage for mock class
    loadingRepositoryMock = LoadingRepositoryImpl(
        remoteDataSource: LoadingMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    loadingRepositoryServerException = LoadingRepositoryImpl(
        remoteDataSource: LoadingRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    loadingRepositoryInternetFailure = LoadingRepositoryImpl(
        remoteDataSource: LoadingRemoteDataSourceImpl(),
        internetInfo: InternetFailureMock());

    loadingSharedRepositoryMock = LoadingRepositoryImpl(
        sharedDataSource: LoadingSharedDataSourceImpl(),
        internetInfo: InternetSuccessMock());
  });

  test(
      'Loading analytics Repository '
      'When calling getRoomDetailData '
      'With Server Exception response data', () async {
    SharedPreferences.setMockInitialValues({"kLoadingJsonData": isNull});
    SharedPreferences.setMockInitialValues({"kLoadingApiFetchedDate": isNull});

    /// Consent user cases impl
    final consentResult =
        await loadingRepositoryServerException!.getLoadingData(_serviceName);

    expect(consentResult.isLeft, true);
  });

  test(
      'Loading analytics Repository '
      'When calling getRoomDetailData '
      'With Internet Failure response data', () async {
    SharedPreferences.setMockInitialValues({"kLoadingJsonData": ""});
    SharedPreferences.setMockInitialValues({"kLoadingApiFetchedDate": ""});

    /// Consent user cases impl
    final consentResult =
        await loadingRepositoryInternetFailure!.getLoadingData(_serviceName);

    expect(consentResult.isLeft, true);
  });

  test(
      'Loading analytics Repository '
      'When calling getRoomDetailData '
      'With Success response data', () async {
    SharedPreferences.setMockInitialValues({"kLoadingJsonData": ""});
    SharedPreferences.setMockInitialValues({"kLoadingApiFetchedDate": ""});

    /// Consent user cases impl
    final consentResult =
        await loadingRepositoryMock!.getLoadingData(_serviceName);

    /// Get model from mock data.
    final LoadingModelData model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getLoadScreen != null, true);
  });

  test(
      'Loading analytics Repository '
      'When calling getRoomDetailData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await loadingSharedRepositoryMock!.getLoadingData(_serviceName);

    /// Get model from mock data.
    final LoadingModelData model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getLoadScreen != null, true);
  });
}
