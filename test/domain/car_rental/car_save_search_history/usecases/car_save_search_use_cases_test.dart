import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/repositories/car_save_search_repository_impl.dart';
import 'package:ota/domain/car_rental/car_save_search_history/usecases/car_save_search_use_cases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  CarSaveSearchHistoryUseCases? carSaveSearchHistoryUseCases;

  CarSaveSearchHistoryArgumentDomain argument =
      CarSaveSearchHistoryArgumentDomain(
          cityId: "cityId",
          countryId: "countryId",
          locationId: "locationId",
          searchKey: "searchKey");

  setUpAll(() async {
    /// Code coverage for default implementation.
    CarSaveSearchHistoryRepository carSaveSearchHistoryRepository =
        CarSaveSearchHistoryRepositoryImpl(
            remoteDataSource: CarSaveSearchHistoryMockDataSourceImpl(),
            internetInfo: InternetSuccessMock());

    carSaveSearchHistoryUseCases = CarSaveSearchHistoryUseCasesImpl(
        repository: carSaveSearchHistoryRepository);
  });

  test('Car save search history use cases test ', () async {
    final result =
        await carSaveSearchHistoryUseCases!.saveCarSearchHistoryData(argument);
    expect(result?.isLeft, false);
  });
}
