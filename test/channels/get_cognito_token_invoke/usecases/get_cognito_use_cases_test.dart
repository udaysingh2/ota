import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/repositories/get_cognito_repository_impl.dart';
import 'package:ota/channels/get_cognito_token_invoke/usecases/get_cognito_use_cases.dart';
import 'package:ota/common/network/failures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("OTA hotel detail handler data source group", () {
    test('OTA hotel detail handler data source', () async {
      GetCognitoUseCasesImpl getCognitoUseCasesImpl =
          GetCognitoUseCasesImpl(repository: GetCognitoRepositoryMock());
      getCognitoUseCasesImpl.invokeExampleMethod(
          methodName: "methodName",
          arguments: GetCognitoArgumentModelChannel());
      getCognitoUseCasesImpl.dispose();
      GetCognitoUseCasesImpl();
    });
  });
}

class GetCognitoRepositoryMock implements GetCognitoRepository {
  @override
  void dispose() {}

  @override
  Future<Either<Failure, GetCognitoResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    return Right(GetCognitoResponseModelChannel());
  }
}
