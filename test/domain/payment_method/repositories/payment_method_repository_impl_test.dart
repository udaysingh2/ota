import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_data_source.dart';
import 'package:ota/domain/payment_method/data_sources/payment_method_remote_mock.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/domain/payment_method/repositories/payment_method_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class MockedPaymentMethodRemoteDataSource
    implements PaymentMethodRemoteDataSource {
  @override
  Future<PaymentMethodModelDomain> getPaymentMethodListData(
      String userId) async {
    Map<String, dynamic> map =
        json.decode(fixture("payment_method/payment_method_result_model.json"));
    PaymentMethodModelDomain sort = PaymentMethodModelDomain.fromMap(map);
    return sort;
  }
}

class MockedPaymentMethodRemoteDataSourceExp
    implements PaymentMethodRemoteDataSource {
  @override
  Future<PaymentMethodModelDomain> getPaymentMethodListData(
      String userId) async {
    throw Exception();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Payment method repo group", () {
    test('Payment method  repo internet success', () async {
      PaymentMethodRepositoryImpl();
      PaymentMethodRepository paymentMethodRepository =
          PaymentMethodRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: PaymentMethodMockDataSourceImpl(),
      );
      paymentMethodRepository.getPaymentMethodListData('');
    });

    test('Payment method  repo internet failure', () async {
      PaymentMethodRepositoryImpl();
      PaymentMethodRepository paymentMethodRepository =
          PaymentMethodRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: MockedPaymentMethodRemoteDataSource(),
      );
      paymentMethodRepository.getPaymentMethodListData('');
    });

    test(
        'Translation analytics Repository '
        'When calling getPaymentMethodListData '
        'With response data', () async {
      PaymentMethodRepositoryImpl();
      PaymentMethodRepository paymentMethodRepository =
          PaymentMethodRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedPaymentMethodRemoteDataSourceExp(),
      );
      try {
        await paymentMethodRepository.getPaymentMethodListData('');
      } catch (_) {}
    });
  });
}
