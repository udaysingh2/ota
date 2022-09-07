import 'package:ota/channels/booking_customer_register_invoke/data_sources/booking_customer_register_data_source.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/common/network/failures.dart';

class BookingCustomerRegisterMockDataSourceImpl
    implements BookingCustomerRegisterDataSource {
  BookingCustomerRegisterMockDataSourceImpl();

  @override
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments}) async {
    return SuccessResponse.success;
  }

  @override
  void dispose() {}
}
