import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/repositories/payment_management_repository.dart';
import 'package:ota/channels/payment_management_invoke/usecases/payment_management_use_cases.dart';

void main() {
  PaymentManagementUseCases? paymentManagementUseCases;
  setUpAll(() async {
    paymentManagementUseCases = PaymentManagementUseCasesImpl();
    paymentManagementUseCases = PaymentManagementUseCasesImpl(
        repository: PaymentManagementRepositoryImpl());
  });

  test('Payment Management Use Cases test', () async {
    // ignore: cancel_subscriptions
    final res = paymentManagementUseCases!.invokeExampleMethod(
        methodName: "paymentManagement",
        arguments: PaymentManagementArgumentModelChannel(
            env: "env",
            language: "language",
            serviceType: "serviceType",
            userId: "userId"));

    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    paymentManagementUseCases!.dispose();
  });
}
