import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/data_sources/ota_search_mock_data_source.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/domain/search/repositories/ota_search_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  OtaSearchRepository? otaSearchRepositoryMock;
  OtaSearchRepository? otaSearchRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    otaSearchRepositoryMock = OtaSearchRepositoryImpl();

    /// Code coverage for mock class
    otaSearchRepositoryMock = OtaSearchRepositoryImpl(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    otaSearchRepositoryInternetFailure = OtaSearchRepositoryImpl(
        remoteDataSource: OtaSearchMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Ota Search analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResultRecommendation = await otaSearchRepositoryMock!
        .getOtaSearchData(OtaSearchDataArgument(
            userId: '1234',
            searchKey: 'Pakchong',
            latitude: 19.7618,
            longitude: 140.542560,
            pageNumber: 1,
            pageSize: '20',
            searchAvailableApi: false));

    /// Get model from mock data.
    final OtaSearchData otaSearchData = consentResultRecommendation.right;

    /// Condition check for hotel value null
    expect(otaSearchData.getOtaSearchResult != null, true);
  });

  test(
      'Ota Search analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResultRecommendation =
        await otaSearchRepositoryInternetFailure!.getOtaSearchData(
            OtaSearchDataArgument(
                userId: '1234',
                searchKey: 'Pakchong',
                latitude: 19.7618,
                longitude: 140.542560,
                pageNumber: 1,
                pageSize: '20',
                searchAvailableApi: false));

    expect(consentResultRecommendation.isLeft, true);
  });
}
