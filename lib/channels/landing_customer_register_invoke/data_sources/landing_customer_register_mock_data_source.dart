import 'package:ota/channels/landing_customer_register_invoke/data_sources/landing_customer_register_data_source.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/common/network/failures.dart';

class LandingCustomerRegisterMockDataSourceImpl
    implements LandingCustomerRegisterDataSource {
  LandingCustomerRegisterMockDataSourceImpl();

  @override
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required LandingCustomerRegisterArgumentModelChannel arguments}) async {
    return SuccessResponse.success;
  }

  @override
  void dispose() {}
}
