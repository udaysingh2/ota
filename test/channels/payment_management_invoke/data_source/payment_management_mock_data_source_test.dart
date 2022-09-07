import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_data_source.dart';
import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_mock_data_source.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Payment management mock data source test', () async {
    PaymentManagementDataSource paymentManagementDataSource =
        PaymentManagementMockDataSourceImpl();
    // ignore: cancel_subscriptions
    final res = paymentManagementDataSource.invokeExampleMethod(
        methodName: "paymentManagement",
        arguments: PaymentManagementArgumentModelChannel(
            env: "env",
            language: "language",
            userId: "userId",
            serviceType: "serviceType"));
    // ignore: unnecessary_null_comparison
    expect(res != null, true);
    paymentManagementDataSource.dispose();
  });
}
