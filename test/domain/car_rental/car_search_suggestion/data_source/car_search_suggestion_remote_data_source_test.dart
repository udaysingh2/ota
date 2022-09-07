import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("landing dynamic playlist mock data source group", () {
    CarSearchSuggestionRemoteDataSource carSearchSuggestionRemoteDataSource =
        CarSearchSuggestionMockDataSourceImpl();
    carSearchSuggestionRemoteDataSource =
        CarSearchSuggestionMockDataSourceImpl();
    CarSearchSuggestionArgumentModelDomain argument =
        CarSearchSuggestionArgumentModelDomain(
            searchCondition: '', serviceType: '', limit: 2, searchType: []);

    test('Hotel landing dynamic playlist mock data source', () async {
      carSearchSuggestionRemoteDataSource.getCarSearchSuggestionData(argument);
    });

    test('Hotel landing dynamic playlist mock data source', () async {
      String response = CarSearchSuggestionMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('Hotel landing dynamic playlist mock data source', () async {
      String response = CarSearchSuggestionMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('Hotel landing dynamic playlist mock data source', () async {
      carSearchSuggestionRemoteDataSource.getCarSearchSuggestionData(argument);
    });
  });
}
