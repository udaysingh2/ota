import 'package:either_dart/either.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_argument_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/repositories/get_user_location_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class GetUserLocationUseCases extends Disposer {
  Future<Either<Failure, GetUserLocationResponseModelChannel>>
      invokeExampleMethod(
          {required String methodName,
          required GetUserLocationArgumentModelChannel arguments});
}

class GetUserLocationUseCasesImpl implements GetUserLocationUseCases {
  GetUserLocationRepository? exampleRepository;

  /// Dependence injection via constructor
  GetUserLocationUseCasesImpl({GetUserLocationRepository? repository}) {
    if (repository == null) {
      exampleRepository = GetUserLocationRepositoryImpl();
    } else {
      exampleRepository = repository;
    }
  }

  @override
  Future<Either<Failure, GetUserLocationResponseModelChannel>>
      invokeExampleMethod(
          {required String methodName,
          required GetUserLocationArgumentModelChannel arguments}) async {
    return await exampleRepository!
        .invokeExampleMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    exampleRepository?.dispose();
  }
}
