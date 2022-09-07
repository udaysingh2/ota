import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class GetCognitoChannelDataSource extends Disposer {
  Future<GetCognitoResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments});
}

class GetCognitoChannelDataSourceImpl
    implements GetCognitoChannelDataSource, Disposer {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannel;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannel = otaMockMethodChannel;
  }

  GetCognitoChannelDataSourceImpl({OtaChannel? otaMethodChannel}) {
    if (_otaMethodChannel != null) {
      this.otaMethodChannel = _otaMethodChannel;
    } else if (otaMethodChannel == null) {
      this.otaMethodChannel = OtaChannelImpl();
    } else {
      this.otaMethodChannel = otaMethodChannel;
    }
  }

  @override
  Future<GetCognitoResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    return GetCognitoResponseModelChannel.fromMap(await otaMethodChannel!
        .invokeNativeMethod(
            methodName: methodName, arguments: arguments.toMap()));
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
