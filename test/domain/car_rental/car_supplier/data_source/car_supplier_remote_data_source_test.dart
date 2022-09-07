import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("car supplier list mock data source group", () {
    CarSupplierRemoteDataSource carSupplierRemoteDataSource =
    CarSupplierMockDataSourceImpl();
    carSupplierRemoteDataSource =
        CarSupplierMockDataSourceImpl();
    CarSupplierArgumentModel argument = CarSupplierArgumentModel(
         '',
         '',
         '',
         '',
         '',
         'N',
         '',
         'THB',
         'day',
         '',
         '',
         30,
    );

    test('Hotel landing dynamic playlist mock data source', () async {
      carSupplierRemoteDataSource.getCarSupplierData(argument);
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
      carSupplierRemoteDataSource.getCarSupplierData(argument);
    });
  });
}
