import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      GetCognitoResponseModelChannel getCognitoArgumentModelChannel =
          GetCognitoResponseModelChannel(
        accessToken: 'access',
        env: 'env',
        idToken: 'idToken',
        userId: "uId",
      );
      getCognitoArgumentModelChannel = GetCognitoResponseModelChannel.fromJson(
          getCognitoArgumentModelChannel.toJson());
      getCognitoArgumentModelChannel = GetCognitoResponseModelChannel.fromMap(
          getCognitoArgumentModelChannel.toMap());
      expect(getCognitoArgumentModelChannel.env, "env");
      expect(getCognitoArgumentModelChannel.accessToken, "access");
      expect(getCognitoArgumentModelChannel.idToken, "idToken");
      expect(getCognitoArgumentModelChannel.userId, "uId");
    });
  });
}
