import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_mock_data_source.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/repositories/payment_management_repository.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

void main() {
  PaymentManagementRegisterRepository? paymentManagementRegisterRepository;

  setUpAll(() async {
    paymentManagementRegisterRepository = PaymentManagementRepositoryImpl();

    paymentManagementRegisterRepository = PaymentManagementRepositoryImpl(
      remoteDataSource: PaymentManagementMockDataSourceImpl(),
    );
  });

  test('Payment Management Repository test', () async {
    final res = await paymentManagementRegisterRepository!.invokeExampleMethod(
        methodName: "paymentManagement",
        arguments: PaymentManagementArgumentModelChannel(
            env: "env",
            language: "language",
            serviceType: "serviceType",
            userId: "userId"));

    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    PaymentManagementRepositoryImpl();
    OtaChannelConfig.isModule = true;
    PaymentManagementRepositoryImpl();
    paymentManagementRegisterRepository!.dispose();
  });
}
