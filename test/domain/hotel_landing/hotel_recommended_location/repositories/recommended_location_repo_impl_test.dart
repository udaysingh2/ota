import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import 'recommended_location_data_source_impl_failure_mock.dart';
import 'recommended_location_data_source_impl_success_mock.dart';

void main() {
  RecommendedLocationRepository? recommendedLocationRepositoryServerException;
  RecommendedLocationRepository? recommendedLocationRepositoryMock;
  RecommendedLocationRepository? recommendedLocationRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    recommendedLocationRepositoryMock = RecommendedLocationRepositoryImpl();

    /// Code coverage for mock class
    recommendedLocationRepositoryMock = RecommendedLocationRepositoryImpl(
        remoteDataSource: RecommendedLocationRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    recommendedLocationRepositoryServerException =
        RecommendedLocationRepositoryImpl(
            remoteDataSource:
                RecommendedLocationRemoteDataSourceImplFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    recommendedLocationRepositoryInternetFailure =
        RecommendedLocationRepositoryImpl(
            remoteDataSource:
                RecommendedLocationRemoteDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock());
  });
  test(
      'Recommended Location Repository '
      'When calling getPlayListResultModelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await recommendedLocationRepositoryMock!
        .getRecommendedLocationData("HOTEL_LANDING");

    /// Get model from mock data.
    final RecommendedLocationModelDomain model = consentResult.right;

    /// Condition check for hotel value null
    expect(model.getRecommendedLocation != null, true);
  });

  test(
      'Recommended Location Repository '
      'When calling getPlayListData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await recommendedLocationRepositoryInternetFailure!
        .getRecommendedLocationData("HOTEL_LANDING");

    expect(consentResult.isLeft, true);
  });

  test(
      'Recommended Location Repository '
      'When calling getPlayListData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final playlistResult = await recommendedLocationRepositoryServerException!
        .getRecommendedLocationData("HOTEL_LANDING");

    expect(playlistResult.isLeft, true);
  });
}
