import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';

void main() {
  CarSaveSearchHistoryArgumentDomain argument =
      CarSaveSearchHistoryArgumentDomain(
          cityId: "cityId",
          countryId: "countryId",
          locationId: "locationId",
          searchKey: "searchKey");

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car save search history mock data source group", () {
    test('Car save search history mock data source', () async {
      CarSaveSearchHistoryRemoteDataSource
          carSaveSearchHistoryRemoteDataSource =
          CarSaveSearchHistoryMockDataSourceImpl();
      carSaveSearchHistoryRemoteDataSource.saveCarSearchHistoryData(argument);
    });
    test('Car save search history mock data source test', () async {
      /// Consent user cases impl
      CarSaveSearchHistoryRemoteDataSource
          carSaveSearchHistoryRemoteDataSource =
          CarSaveSearchHistoryMockDataSourceImpl();
      final result = await carSaveSearchHistoryRemoteDataSource
          .saveCarSearchHistoryData(argument);

      /// Condition check for reject booking value null
      expect(result.saveRecentCarRentalSearchHistory != null, true);
    });
  });
}
