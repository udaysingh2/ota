import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';
import 'package:ota/domain/car_rental/car_search_history/repositories/car_search_history_repository.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarSearchHistoryRemoteDataSourceFailureMock
    implements CarSearchHistoryRemoteDataSource {
  @override
  Future<CarSearchHistoryModelDomainData> getCarSearchHistoryData() {
    throw exp.ServerException(null);
  }
}

void main() {
  CarSearchHistoryRepository? carSearchHistoryRepositoryMock;
  CarSearchHistoryRepository? carSearchHistoryRepositoryInternetFailure;
  CarSearchHistoryRepository? carSearchHistoryRepositoryServerException;

  setUpAll(() async {
    /// Code coverage for default implementation.
    carSearchHistoryRepositoryMock = CarSearchHistoryRepositoryImpl();

    /// Code coverage for mock class
    carSearchHistoryRepositoryMock = CarSearchHistoryRepositoryImpl(
        remoteDataSource: CarSearchHistoryMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carSearchHistoryRepositoryServerException = CarSearchHistoryRepositoryImpl(
        remoteDataSource: CarSearchHistoryRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carSearchHistoryRepositoryInternetFailure = CarSearchHistoryRepositoryImpl(
        remoteDataSource: CarSearchHistoryRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Car Search Repository '
      'With Success response data', () async {
    final result =
        await carSearchHistoryRepositoryMock!.getCarSearchHistoryData();

    /// Get model from mock data.
    final CarSearchHistoryModelDomainData carSearchHistoryModelDomain =
        result.right;

    expect(
        carSearchHistoryModelDomain.getCarRentalRecentSearches != null, true);
  });

  test(
      'Car Search Repository'
      'With Internet Failure response data', () async {
    final result = await carSearchHistoryRepositoryInternetFailure!
        .getCarSearchHistoryData();

    expect(result.isLeft, true);
  });

  test(
      'Car Search Repository'
      'With Server Exception response data', () async {
    final result = await carSearchHistoryRepositoryServerException!
        .getCarSearchHistoryData();

    expect(result.isLeft, true);
  });
}
