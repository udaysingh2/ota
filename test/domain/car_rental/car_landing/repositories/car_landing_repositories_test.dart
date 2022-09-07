import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_landing/data_source/car_landing_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_landing/models/clear_recent_search_domain_model.dart';
import 'package:ota/domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/car_rental/car_landing/repositories/car_landing_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarLandingRemoteDataSourceFailureMock
    implements CarLandingRemoteDataSource {
  @override
  Future<ClearRecentSearchDomainModel> clearRecentSearch(
      String serviceType, String dataSearchType) {
    throw exp.ServerException(null);
  }

  @override
  Future<LandingRecentSearchDomainModel> getRecentSearches(
      String serviceType, String dataSearchType) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarLandingRepository? carLandingRepositoryInternetFailure;
  CarLandingRepository? carLandingRepositoryServerException;

  setUpAll(() async {
    carLandingRepositoryServerException = CarLandingRepositoryImpl(
        remoteDataSource: CarLandingRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carLandingRepositoryInternetFailure = CarLandingRepositoryImpl(
        remoteDataSource: CarLandingRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'car landing Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carLandingRepositoryInternetFailure!
        .getRecentSearchData("searchType", "defaultSearchType");

    expect(result.isLeft, true);
  });
  test(
      'car landing Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carLandingRepositoryInternetFailure!
        .clearRecentSearch("searchType", "defaultSearchType");

    expect(result.isLeft, true);
  });

  test(
      'car landing Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carLandingRepositoryServerException!
        .getRecentSearchData("searchType", "defaultSearchType");

    expect(result.isLeft, true);
  });
}
