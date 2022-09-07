import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source_mock.dart';
import 'package:ota/domain/landing/models/landing_models.dart';
import 'package:ota/domain/landing/repositories/landing_page_repository_impl.dart';

import '../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/landing_page_remote_datasource_impl_failure_mock.dart';

void main() {
  LandingPageRepository? landingPageRepositoryServerException;
  LandingPageRepository? landingPageRepositoryMock;
  LandingPageRepository? landingPageRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    landingPageRepositoryMock = LandingPageRepositoryImpl();

    /// Code coverage for mock class
    landingPageRepositoryMock = LandingPageRepositoryImpl(
        remoteDataSource: LandingPageMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    landingPageRepositoryServerException = LandingPageRepositoryImpl(
        remoteDataSource: LandingPageRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    landingPageRepositoryInternetFailure = LandingPageRepositoryImpl(
        remoteDataSource: LandingPageRemoteDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Landing analytics Repository '
      'When calling getRoomDetailData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await landingPageRepositoryMock!.getLandingPage();

    /// Get model from mock data.
    final LandingData? model = consentResult.right;

    /// Condition check for hotel value null
    expect(model?.getLandingPageDetails != null, true);
  });

  test(
      'Landing analytics Repository '
      'When calling getRoomDetailData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult =
        await landingPageRepositoryInternetFailure!.getLandingPage();

    expect(consentResult.isLeft, true);
  });

  test(
      'Landing analytics Repository '
      'When calling getRoomDetailData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult =
        await landingPageRepositoryServerException!.getLandingPage();

    expect(consentResult.isLeft, true);
  });
}
