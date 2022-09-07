import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_mock.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';

void main() {
  CustomerMockDataSourceImpl impl = CustomerMockDataSourceImpl();
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  test('For getMockData test', () {
    final actual = CustomerMockDataSourceImpl.getMockData();

    expect(actual.isNotEmpty, true);
  });

  test('For CustomerMockDataSourceImpl ==> getCustomerData test', () {
    final actual = impl.getCustomerData();

    expect(actual, isA<Future<CustomerData>>());
  });
}
