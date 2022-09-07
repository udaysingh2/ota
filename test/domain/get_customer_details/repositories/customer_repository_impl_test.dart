import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class MockedCustomerRemoteDataSource implements CustomerRemoteDataSource {
  @override
  Future<CustomerData> getCustomerData() async {
    Map<String, dynamic> map =
        json.decode(fixture("get_customer_details/customer_details.json"));
    CustomerData customerData = CustomerData.fromMap(map);
    return customerData;
  }
}

class MockedCustomerDataSourceExp implements CustomerRemoteDataSource {
  @override
  Future<CustomerData> getCustomerData() async {
    throw Exception();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Customer details repository test", () {
    test('customer details repo test for internet success', () async {
      CustomerRepositoryImpl();
      CustomerRepository customerRepository = CustomerRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedCustomerRemoteDataSource(),
      );
      customerRepository.getCustomerData();
    });

    test('customer details repo test for internet failure', () async {
      CustomerRepositoryImpl();
      CustomerRepository customerRepository = CustomerRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedCustomerRemoteDataSource(),
      );
      customerRepository.getCustomerData();
    });

    test('customer details repo test for exception', () async {
      CustomerRepositoryImpl();
      CustomerRepository customerRepository = CustomerRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedCustomerDataSourceExp(),
      );
      try {
        await customerRepository.getCustomerData();
      } catch (error) {
        return (error);
      }
    });
  });
}
