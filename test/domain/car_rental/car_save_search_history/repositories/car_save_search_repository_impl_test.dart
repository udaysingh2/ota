import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';
import 'package:ota/domain/car_rental/car_save_search_history/repositories/car_save_search_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarSaveSearchHistoryRemoteDataSourceFailureMock
    implements CarSaveSearchHistoryRemoteDataSource {
  @override
  Future<CarSaveSearchHistoryModelDomain> saveCarSearchHistoryData(
      CarSaveSearchHistoryArgumentDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarSaveSearchHistoryRepository? carSaveSearchHistoryRepositoryMock;
  CarSaveSearchHistoryRepository? carSaveSearchHistoryRepositoryInternetFailure;
  CarSaveSearchHistoryRepository? carSaveSearchHistoryRepositoryServerException;

  CarSaveSearchHistoryArgumentDomain argument =
      CarSaveSearchHistoryArgumentDomain(
          cityId: "cityId",
          countryId: "countryId",
          locationId: "locationId",
          searchKey: "searchKey");

  setUpAll(() async {
    /// Code coverage for default implementation.
    carSaveSearchHistoryRepositoryMock = CarSaveSearchHistoryRepositoryImpl();

    /// Code coverage for mock class
    carSaveSearchHistoryRepositoryMock = CarSaveSearchHistoryRepositoryImpl(
        remoteDataSource: CarSaveSearchHistoryMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carSaveSearchHistoryRepositoryServerException =
        CarSaveSearchHistoryRepositoryImpl(
            remoteDataSource: CarSaveSearchHistoryRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carSaveSearchHistoryRepositoryInternetFailure =
        CarSaveSearchHistoryRepositoryImpl(
            remoteDataSource: CarSaveSearchHistoryRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Car Save Search Repository '
      'With Success response data', () async {
    final result = await carSaveSearchHistoryRepositoryMock!
        .saveCarSearchHistoryData(argument);

    /// Get model from mock data.
    final CarSaveSearchHistoryModelDomain carSaveSearchHistoryModelDomain =
        result.right;

    expect(
        carSaveSearchHistoryModelDomain.saveRecentCarRentalSearchHistory !=
            null,
        true);
  });

  test(
      'Car Save Search Repository'
      'With Internet Failure response data', () async {
    final result = await carSaveSearchHistoryRepositoryInternetFailure!
        .saveCarSearchHistoryData(argument);

    expect(result.isLeft, true);
  });

  test(
      'Car Save Search Repository'
      'With Server Exception response data', () async {
    final result = await carSaveSearchHistoryRepositoryServerException!
        .saveCarSearchHistoryData(argument);

    expect(result.isLeft, true);
  });
}
