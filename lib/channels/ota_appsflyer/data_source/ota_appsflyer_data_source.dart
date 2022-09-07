import 'package:ota/channels/ota_appsflyer/model/ota_appsflyer_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class GetAppsFlyerChannelDataSource extends Disposer {
  void invokeExampleMethod({
    required String methodName,
    required GetAppsFlyerModelChannel arguments,
  });
}

class GetAppsFlyerChannelDataSourceImpl
    implements GetAppsFlyerChannelDataSource, Disposer {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannel;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannel = otaMockMethodChannel;
  }

  GetAppsFlyerChannelDataSourceImpl({OtaChannel? otaMethodChannel}) {
    if (_otaMethodChannel != null) {
      this.otaMethodChannel = _otaMethodChannel;
    } else if (otaMethodChannel == null) {
      this.otaMethodChannel = OtaChannelImpl();
    } else {
      this.otaMethodChannel = otaMethodChannel;
    }
  }

  @override
  void invokeExampleMethod({
    required String methodName,
    required GetAppsFlyerModelChannel arguments,
  }) {
    otaMethodChannel!.invokeNativeMethod(
      methodName: methodName,
      arguments: arguments.toMap(),
    );
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
