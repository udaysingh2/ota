import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/repositories/get_cognito_repository_impl.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      GetCognitoRepositoryImpl getCognitoRepositoryImpl =
          GetCognitoRepositoryImpl(
              remoteDataSource: GetMockGetCognitoChannelDataSource());
      getCognitoRepositoryImpl.invokeExampleMethod(
          methodName: "methodName",
          arguments: GetCognitoArgumentModelChannel());

      GetCognitoRepositoryImpl getCognitoRepositoryImplEx =
          GetCognitoRepositoryImpl(
              remoteDataSource: GetMockGetCognitoChannelDataSourceEx());
      getCognitoRepositoryImplEx.invokeExampleMethod(
          methodName: "methodName",
          arguments: GetCognitoArgumentModelChannel());
      getCognitoRepositoryImplEx.dispose();
      GetCognitoRepositoryImpl();
      OtaChannelConfig.isModule = true;
      GetCognitoRepositoryImpl();
    });
  });
}

class GetMockGetCognitoChannelDataSource
    implements GetCognitoChannelDataSource {
  @override
  void dispose() {}

  @override
  Future<GetCognitoResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    return GetCognitoResponseModelChannel();
  }
}

class GetMockGetCognitoChannelDataSourceEx
    implements GetCognitoChannelDataSource {
  @override
  void dispose() {}

  @override
  Future<GetCognitoResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    throw Exception();
  }
}
