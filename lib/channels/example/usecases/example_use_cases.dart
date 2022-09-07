import 'package:either_dart/either.dart';
import 'package:ota/channels/example/models/example_argument_model_channel.dart';
import 'package:ota/channels/example/models/example_response_model_channel.dart';
import 'package:ota/channels/example/repositories/example_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class ExampleUseCases extends Disposer {
  Future<Either<Failure, ExampleResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments});
}

class ExampleUseCasesImpl implements ExampleUseCases {
  ExampleRepository? exampleRepository;

  /// Dependence injection via constructor
  ExampleUseCasesImpl({ExampleRepository? repository}) {
    if (repository == null) {
      exampleRepository = ExampleRepositoryImpl();
    } else {
      exampleRepository = repository;
    }
  }

  @override
  Future<Either<Failure, ExampleResponseModelChannel>> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments}) async {
    return await exampleRepository!
        .invokeExampleMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    exampleRepository?.dispose();
  }
}
