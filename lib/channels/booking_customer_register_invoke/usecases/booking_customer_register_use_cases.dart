import 'package:either_dart/either.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/repositories/booking_customer_register_repository.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/common/network/failures.dart';

/// Interface for ExampleUseCases.
abstract class BookingCustomerRegisterUseCases extends Disposer {
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments});
}

class BookingCustomerRegisterUseCasesImpl
    implements BookingCustomerRegisterUseCases {
  BookingCustomerRegisterRepository? landingCustomerRegisterRepository;

  /// Dependence injection via constructor
  BookingCustomerRegisterUseCasesImpl(
      {BookingCustomerRegisterRepository? repository}) {
    if (repository == null) {
      landingCustomerRegisterRepository =
          BookingCustomerRegisterRepositoryImpl();
    } else {
      landingCustomerRegisterRepository = repository;
    }
  }

  @override
  Future<Either<Failure, SuccessResponse>> invokeExampleMethod(
      {required String methodName,
      required BookingCustomerRegisterArgumentModelChannel arguments}) async {
    return await landingCustomerRegisterRepository!
        .invokeExampleMethod(methodName: methodName, arguments: arguments);
  }

  @override
  void dispose() {
    landingCustomerRegisterRepository?.dispose();
  }
}
