import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_landing/data_source/car_landing_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_landing/data_source/car_landing_remote_data_source.dart';

const String searchType = "searchType";
const String defaultSearchType = "defaultSearchType";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("landing dynamic playlist mock data source group", () {
    CarLandingRemoteDataSource carLandingRemoteDataSource =
        CarLandingRemoteDataSourceImpl();
    carLandingRemoteDataSource = CarLandingMockDataSourceImpl();

    test('car reservation mock data source', () async {
      carLandingRemoteDataSource.getRecentSearches(
          searchType, defaultSearchType);
    });
    test('car reservation mock data source', () async {
      carLandingRemoteDataSource.clearRecentSearch(
          searchType, defaultSearchType);
    });

    test('car reservation mock data source', () async {
      String response = CarLandingMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car reservation mock data source', () async {
      String response = CarLandingMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car reservation mock data source', () async {
      carLandingRemoteDataSource.getRecentSearches(
          searchType, defaultSearchType);
    });
  });
}
