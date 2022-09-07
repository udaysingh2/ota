import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_mock_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      GetCognitoChannelDataSourceImpl getCognitoChannelDataSourceImpl =
          GetCognitoChannelDataSourceImpl(otaMethodChannel: OtaMockChannel());
      GetCognitoChannelDataSourceImpl getCognitoChannelDataSource =
          GetCognitoChannelDataSourceImpl();
      expect(getCognitoChannelDataSource.otaMethodChannel is OtaMockChannel,
          false);
      expect(getCognitoChannelDataSourceImpl.otaMethodChannel is OtaMockChannel,
          true);
      getCognitoChannelDataSourceImpl.invokeExampleMethod(
          methodName: "methodName",
          arguments: GetCognitoArgumentModelChannel());
      GetCognitoChannelDataSourceImpl.setMock(OtaMockChannel());
      GetCognitoChannelDataSourceImpl getCognitoChannelDataSourceMock =
          GetCognitoChannelDataSourceImpl();
      expect(getCognitoChannelDataSourceMock.otaMethodChannel is OtaMockChannel,
          true);
      getCognitoChannelDataSourceImpl.dispose();
    });
  });
}

class OtaMockChannel implements OtaChannel {
  @override
  void dispose() {}

  @override
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic>) nativeResponse,
      bool? isDuplicateAllowed}) {
    throw UnimplementedError();
  }

  @override
  StreamSubscription handleNativeMethod(
      String methodName, Function(Map<String, dynamic> p1) nativeResponse) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> invokeNativeMethod(
      {required String methodName,
      required Map<String, dynamic> arguments}) async {
    return GetCognitoResponseModelChannel.fromJson(
            GetCognitoMockDataSourceImpl.getMockData())
        .toMap();
  }
}
