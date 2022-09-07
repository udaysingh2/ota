import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/get_cognito_token_invoke/data_sources/get_cognito_mock_data_source.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      GetCognitoMockDataSourceImpl.setMock(
          GetCognitoMockDataSourceImpl.getMockData());
      GetCognitoMockDataSourceImpl().invokeExampleMethod(
          methodName: "methodName",
          arguments: GetCognitoArgumentModelChannel());
      GetCognitoMockDataSourceImpl().dispose();
    });
  });
}
