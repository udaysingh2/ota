import 'package:ota/channels/payment_management_invoke/data_sources/payment_management_data_source.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/common/network/failures.dart';

class PaymentManagementMockDataSourceImpl
    implements PaymentManagementDataSource {
  PaymentManagementMockDataSourceImpl();

  @override
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required PaymentManagementArgumentModelChannel arguments}) async {
    return SuccessResponse.success;
  }

  @override
  void dispose() {}
}
