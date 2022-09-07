import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';
import 'package:ota/domain/get_customer_details/usecases/customer_use_cases.dart';

import '../../../mocks/fixture_reader.dart';

class _CustomerUseCase implements CustomerRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  CustomerRemoteDataSource? customerRemoteDataSource;

  @override
  Future<Either<Failure, CustomerData>> getCustomerData() async {
    Map<String, dynamic> map =
        json.decode(fixture("get_customer_details/customer_details.json"));
    CustomerData customerData = CustomerData.fromMap(map);
    return Right(customerData);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Customer Use case group", () {
    test('Customer Use case test', () async {
      CustomerUseCasesImpl();
      CustomerUseCases customerUseCases =
          CustomerUseCasesImpl(repository: _CustomerUseCase());
      customerUseCases.getCustomerData();
    });
  });
}
