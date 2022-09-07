import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source_mock.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class BannerRemoteDataSourceFailureMock
    implements LandingBannerRemoteDataSource {
  @override
  Future<LandingBannerModelDomain> getLandingBanner(String bannerType) {
    throw exp.ServerException(null);
  }
}

void main() {
  LandingBannerRepository? landingBannerRepositoryMock;
  LandingBannerRepository? landingBannerRepositoryInternetFailure;
  LandingBannerRepository? landingBannerRepositoryServerException;

  setUpAll(() async {
    /// Code coverage for default implementation.
    landingBannerRepositoryMock = LandingBannerRepositoryImpl();

    /// Code coverage for mock class
    landingBannerRepositoryMock = LandingBannerRepositoryImpl(
        remoteDataSource: LandingBannerMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    landingBannerRepositoryServerException = LandingBannerRepositoryImpl(
        remoteDataSource: BannerRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    landingBannerRepositoryInternetFailure = LandingBannerRepositoryImpl(
        remoteDataSource: BannerRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Hotel landing dynamic playlist Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result =
        await landingBannerRepositoryMock!.getLandingBanner("bannerType");

    /// Get model from mock data.
    final LandingBannerModelDomain? bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData?.getBanners != null, true);
  });

  test(
      'hotel Dynamic Playlist Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await landingBannerRepositoryInternetFailure!
        .getLandingBanner("bannerType");

    expect(result.isLeft, true);
  });

  test(
      'hotel Dynamic Playlist Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await landingBannerRepositoryServerException!
        .getLandingBanner("bannerType");

    expect(result.isLeft, true);
  });
}
