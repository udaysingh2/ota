import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class BookingCustomerRegisterDataSource extends Disposer {
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments});
}

class BookingCustomerRegisterDataSourceImpl
    implements BookingCustomerRegisterDataSource, Disposer {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannel;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannel = otaMockMethodChannel;
  }

  BookingCustomerRegisterDataSourceImpl({OtaChannel? otaMethodChannel}) {
    if (_otaMethodChannel != null) {
      this.otaMethodChannel = _otaMethodChannel;
    } else if (otaMethodChannel == null) {
      this.otaMethodChannel = OtaChannelImpl();
    } else {
      this.otaMethodChannel = otaMethodChannel;
    }
  }

  @override
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments}) async {
    await otaMethodChannel!.invokeNativeMethod(
        methodName: methodName, arguments: arguments.toMap());
    return SuccessResponse.success;
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
