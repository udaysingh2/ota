import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/landing/data_sources/landing_page_remote_data_source.dart';
import 'package:ota/domain/landing/repositories/landing_page_repository_impl.dart';

import '../../hotel/repositories/internet_success_mock.dart';
import '../repositories/landing_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponseLanding = MockLandingGraphQl();
  LandingPageRemoteDataSourceImpl.setMock(graphQlResponseLanding);
  LandingPageRepository landingPageRepository = LandingPageRepositoryImpl(
      remoteDataSource: LandingPageRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Landing Page Data Source", () {
    LandingPageRemoteDataSource landingPageRemoteDataSource =
        LandingPageRemoteDataSourceImpl();
    LandingPageRemoteDataSourceImpl.setMock(graphQlResponseLanding);
    landingPageRemoteDataSource.getLandingPage();
  });
  test(
      'Landing Page analytics Repository '
      'When calling getGalleryResultModelUrlData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await landingPageRepository.getLandingPage();

    expect(consentResult.isRight, true);
  });
}
