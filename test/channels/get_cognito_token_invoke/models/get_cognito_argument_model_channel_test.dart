import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      GetCognitoArgumentModelChannel getCognitoArgumentModelChannel =
          GetCognitoArgumentModelChannel(
        accessToken: 'access',
        env: 'env',
        idToken: 'idToken',
        userId: "uId",
      );
      getCognitoArgumentModelChannel = GetCognitoArgumentModelChannel.fromJson(
          getCognitoArgumentModelChannel.toJson());
      getCognitoArgumentModelChannel = GetCognitoArgumentModelChannel.fromMap(
          getCognitoArgumentModelChannel.toMap());
      expect(getCognitoArgumentModelChannel.env, "env");
      expect(getCognitoArgumentModelChannel.accessToken, "access");
      expect(getCognitoArgumentModelChannel.idToken, "idToken");
      expect(getCognitoArgumentModelChannel.userId, "uId");
    });
  });
}
