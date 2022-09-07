import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/domain/payment_method/repositories/payment_method_repository_impl.dart';

/// Interface for Payment Method use cases.
abstract class PaymentMethodUseCases {
  /// Call API to get the Payment Method Screen details.
  ///
  /// [userId] to get the Payment Method Data for users.
  /// [Either<Failure, PaymentMethodModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, PaymentMethodModelDomain>?> getPaymentMethodListData({
    required String userId,
  });
}

/// PaymentMethodUseCasesImpl will contain the PaymentMethodUseCases implementation.
class PaymentMethodUseCasesImpl implements PaymentMethodUseCases {
  PaymentMethodRepository? paymentMethodRepository;

  /// Dependence injection via constructor
  PaymentMethodUseCasesImpl({PaymentMethodRepository? repository}) {
    if (repository == null) {
      paymentMethodRepository = PaymentMethodRepositoryImpl();
    } else {
      paymentMethodRepository = repository;
    }
  }

  /// Call API to get the Payment Method Screen Details details.
  ///
  /// [userId] to get the Payment Method Data for users.
  /// [Either<Failure, PaymentMethodModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PaymentMethodModelDomain>?> getPaymentMethodListData({
    required String userId,
  }) async {
    return await paymentMethodRepository?.getPaymentMethodListData(userId);
  }
}
