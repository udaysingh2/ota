import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_data_source.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("payment method mock data source group", () {
    test('Payment method mock data source', () async {
      PaymentMethodRemoteDataSource otaSearchSortRemoteDataSource =
          PaymentMethodMockDataSourceImpl();
      otaSearchSortRemoteDataSource = PaymentMethodMockDataSourceImpl();
      otaSearchSortRemoteDataSource.getPaymentMethodListData('');
    });

    test('Payment method mock data source', () async {
      String response = PaymentMethodMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
  });
}
