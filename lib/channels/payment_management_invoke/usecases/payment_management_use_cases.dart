import 'package:either_dart/either.dart';
import 'package:ota/channels/payment_management_invoke/models/payment_management_argument_model_channel.dart';
import 'package:ota/channels/payment_management_invoke/repositories/payment_management_repository.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class PaymentManagementUseCases extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required PaymentManagementArgumentModelChannel arguments});
}

class PaymentManagementUseCasesImpl implements PaymentManagementUseCases {
  PaymentManagementRegisterRepository? paymentManagementRepository;

  /// Dependence injection via constructor
  PaymentManagementUseCasesImpl(
      {PaymentManagementRegisterRepository? repository}) {
    if (repository == null) {
      paymentManagementRepository = PaymentManagementRepositoryImpl();
    } else {
      paymentManagementRepository = repository;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required PaymentManagementArgumentModelChannel arguments}) async {
    return await paymentManagementRepository!
        .invokeExampleMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    paymentManagementRepository?.dispose();
  }
}
