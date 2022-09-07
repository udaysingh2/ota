import 'package:either_dart/either.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/channels/landing_customer_register_invoke/repositories/landing_customer_register_repository.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class LandingCustomerRegisterUseCases extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required LandingCustomerRegisterArgumentModelChannel arguments});
}

class LandingCustomerRegisterUseCasesImpl
    implements LandingCustomerRegisterUseCases {
  LandingCustomerRegisterRepository? landingCustomerRegisterRepository;

  /// Dependence injection via constructor
  LandingCustomerRegisterUseCasesImpl(
      {LandingCustomerRegisterRepository? repository}) {
    if (repository == null) {
      landingCustomerRegisterRepository =
          LandingCustomerRegisterRepositoryImpl();
    } else {
      landingCustomerRegisterRepository = repository;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required LandingCustomerRegisterArgumentModelChannel arguments}) async {
    return await landingCustomerRegisterRepository!
        .invokeExampleMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    landingCustomerRegisterRepository?.dispose();
  }
}
