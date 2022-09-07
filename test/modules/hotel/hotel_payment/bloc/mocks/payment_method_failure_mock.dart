import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/domain/payment_method/usecases/payment_method_use_cases.dart';

class PaymentMethodUseCasesFailureMock extends PaymentMethodUseCases {
  @override
  Future<Either<Failure, PaymentMethodModelDomain>?> getPaymentMethodListData(
      {required String userId}) async {
    return Left(InternetFailure());
  }
}
