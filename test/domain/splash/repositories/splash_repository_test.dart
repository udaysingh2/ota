import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

import 'package:ota/domain/splash/data_sources/splash_mock_data_source.dart';
import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';
import 'package:ota/domain/splash/models/splash_model.dart';
import 'package:ota/domain/splash/repositories/splash_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class SplashRemoteDataSourceFailureMock implements SplashRemoteDataSource {
  @override
  Future<SplashModel> getSplashData() {
    throw exp.ServerException(null);
  }
}

void main() {
  SplashRepository? splashRepositoryMock;
  SplashRepository? splashRepositoryInternetFailure;
  SplashRepository? splashRepositoryServerException;
  setUpAll(() async {
    /// Code coverage for default implementation.
    splashRepositoryMock = SplashRepositoryImpl();

    /// Code coverage for mock class
    splashRepositoryMock = SplashRepositoryImpl(
        remoteDataSource: SplashMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    splashRepositoryInternetFailure = SplashRepositoryImpl(
        remoteDataSource: SplashRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());

    /// Coverage in-case of SERVER failure
    splashRepositoryServerException = SplashRepositoryImpl(
        remoteDataSource: SplashRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'splash Repository Mock Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await splashRepositoryMock!.getSplashData();

    /// Get model from mock data.
    final SplashModel popUp = result.right;

    /// Condition check for booking data value null
    expect(popUp.getSplashScreen != null, true);
  });

  test(
      'splash Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await splashRepositoryInternetFailure!.getSplashData();

    expect(result.isLeft, true);
  });

  test(
      'splash Repository ServerE xception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await splashRepositoryServerException!.getSplashData();

    expect(result.isLeft, true);
  });
}
