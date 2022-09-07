import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car search history mock data source group", () {
    test('Car search history mock data source', () async {
      CarSearchHistoryRemoteDataSource carSearchHistoryRemoteDataSource =
          CarSearchHistoryMockDataSourceImpl();
      carSearchHistoryRemoteDataSource.getCarSearchHistoryData();
    });
    test('Car search history mock data source test', () async {
      /// Consent user cases impl
      CarSearchHistoryRemoteDataSource carSearchHistoryRemoteDataSource =
          CarSearchHistoryMockDataSourceImpl();
      final result =
          await carSearchHistoryRemoteDataSource.getCarSearchHistoryData();

      /// Condition check for reject booking value null
      expect(result.getCarRentalRecentSearches != null, true);
    });
  });
}
