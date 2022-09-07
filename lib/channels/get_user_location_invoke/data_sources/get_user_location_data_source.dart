import 'package:ota/channels/get_user_location_invoke/models/get_user_location_argument_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class GetUserLocationChannelDataSource extends Disposer {
  Future<GetUserLocationResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetUserLocationArgumentModelChannel arguments});
}

class GetUserLocationChannelDataSourceImpl
    implements GetUserLocationChannelDataSource, Disposer {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannel;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannel = otaMockMethodChannel;
  }

  GetUserLocationChannelDataSourceImpl({OtaChannel? otaMethodChannel}) {
    if (_otaMethodChannel != null) {
      this.otaMethodChannel = _otaMethodChannel;
    } else if (otaMethodChannel == null) {
      this.otaMethodChannel = OtaChannelImpl();
    } else {
      this.otaMethodChannel = otaMethodChannel;
    }
  }

  @override
  Future<GetUserLocationResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetUserLocationArgumentModelChannel arguments}) async {
    return GetUserLocationResponseModelChannel.fromMap(await otaMethodChannel!
        .invokeNativeMethod(
            methodName: methodName, arguments: arguments.toMap()));
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
