import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/domain/payment_method/usecases/payment_method_use_cases.dart';

class PaymentMethodUseCasesSuccessMock extends PaymentMethodUseCases {
  @override
  Future<Either<Failure, PaymentMethodModelDomain>?> getPaymentMethodListData(
      {required String userId}) async {
    return Right(PaymentMethodModelDomain(
        getCustomerPaymentMethodDetails: GetCustomerPaymentMethodDetails(
      data: Data(cardCurrent: 10, cardMaximum: 100, paymentList: [
        PaymentList(),
      ]),
      status: Status(),
    )));
  }
}
