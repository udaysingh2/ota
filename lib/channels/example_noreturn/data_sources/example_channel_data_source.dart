import 'package:ota/channels/example_noreturn/models/example_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class ExampleChannelDataSource extends Disposer {
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments});
}

class ExampleChannelDataSourceImpl
    implements ExampleChannelDataSource, Disposer {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannel;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannel = otaMockMethodChannel;
  }

  ExampleChannelDataSourceImpl({OtaChannel? otaMethodChannel}) {
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
      required ExampleArgumentModelChannel arguments}) async {
    await otaMethodChannel!.invokeNativeMethod(
        methodName: methodName, arguments: arguments.toMap());
    return SuccessResponse.success;
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
