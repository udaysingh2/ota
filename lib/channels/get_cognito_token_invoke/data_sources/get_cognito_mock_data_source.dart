import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';

class GetCognitoMockDataSourceImpl implements GetCognitoChannelDataSource {
  GetCognitoMockDataSourceImpl();
  static String _responseMock = """
  {
    "from": "superapp_register",
    "to": "ota_landing",
    "userId": "55bdb958-97e8-4c10-bfa0-7ed1d8d6973b-02E0JPDV",
    "userType": "ACTIVE",
    "language": "TH",
    "envId": "DEV"
  }
  """;

  static String getMockData() {
    return _responseMock;
  }

  static void setMock(String mock) {
    _responseMock = mock;
  }

  @override
  Future<GetCognitoResponseModelChannel> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    return GetCognitoResponseModelChannel.fromJson(_responseMock);
  }

  @override
  void dispose() {}
}
