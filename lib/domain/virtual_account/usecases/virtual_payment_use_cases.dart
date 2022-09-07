import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/virtual_account/models/virtual_payment_model_domain.dart';
import 'package:ota/domain/virtual_account/repositories/virtual_payment_repository_impl.dart';

abstract class VirtualPaymentUseCases {
  Future<Either<Failure, VirtualPaymentModelDomain>?> getVirtualWalletBalance();
}

class VirtualPaymentUseCasesImpl implements VirtualPaymentUseCases {
  VirtualPaymentRepository? virtualPaymentRepository;

  VirtualPaymentUseCasesImpl({VirtualPaymentRepository? repository}) {
    if (repository == null) {
      virtualPaymentRepository = VirtualPaymentRepositoryImpl();
    } else {
      virtualPaymentRepository = repository;
    }
  }

  @override
  Future<Either<Failure, VirtualPaymentModelDomain>?>
      getVirtualWalletBalance() async {
    return await virtualPaymentRepository?.getVirtualWalletBalance();
  }
}
