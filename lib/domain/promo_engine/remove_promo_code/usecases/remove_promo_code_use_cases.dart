import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/repositories/remove_promo_code_repository_impl.dart';

abstract class RemovePromoCodeUseCases {
  Future<Either<Failure, RemovePromoCodeModelDomain>?> getRemovePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain);
}

class RemovePromoCodeUseCasesImpl implements RemovePromoCodeUseCases {
  RemovePromoCodeRepository? removePromoCodeRepository;

  ///Dependency injection via constructor
  RemovePromoCodeUseCasesImpl({RemovePromoCodeRepository? repository}) {
    if (repository == null) {
      removePromoCodeRepository = RemovePromoCodeRepositoryImpl();
    } else {
      removePromoCodeRepository = repository;
    }
  }

  @override
  Future<Either<Failure, RemovePromoCodeModelDomain>?> getRemovePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    return await removePromoCodeRepository?.removePromoCodeData(argumentDomain);
  }
}
