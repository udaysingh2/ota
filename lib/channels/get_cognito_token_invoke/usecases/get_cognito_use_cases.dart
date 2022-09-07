import 'package:either_dart/either.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/repositories/get_cognito_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class GetCognitoUseCases extends Disposer {
  Future<Either<Failure, GetCognitoResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments});
}

class GetCognitoUseCasesImpl implements GetCognitoUseCases {
  GetCognitoRepository? exampleRepository;

  /// Dependence injection via constructor
  GetCognitoUseCasesImpl({GetCognitoRepository? repository}) {
    if (repository == null) {
      exampleRepository = GetCognitoRepositoryImpl();
    } else {
      exampleRepository = repository;
    }
  }

  @override
  Future<Either<Failure, GetCognitoResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required GetCognitoArgumentModelChannel arguments}) async {
    return await exampleRepository!
        .invokeExampleMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    exampleRepository?.dispose();
  }
}
