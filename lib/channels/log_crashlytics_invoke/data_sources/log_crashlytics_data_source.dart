import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class LogCrashlyticsDataSource extends Disposer {
  Future<SuccessResponse> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments});
}

class PaymentManagementDataSourceImpl
    implements LogCrashlyticsDataSource, Disposer {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannel;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannel = otaMockMethodChannel;
  }

  PaymentManagementDataSourceImpl({OtaChannel? otaMethodChannel}) {
    if (_otaMethodChannel != null) {
      this.otaMethodChannel = _otaMethodChannel;
    } else if (otaMethodChannel == null) {
      this.otaMethodChannel = OtaChannelImpl();
    } else {
      this.otaMethodChannel = otaMethodChannel;
    }
  }

  @override
  Future<SuccessResponse> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments}) async {
    await otaMethodChannel!.invokeNativeMethod(
        methodName: methodName, arguments: arguments.toMap());
    return SuccessResponse.success;
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
