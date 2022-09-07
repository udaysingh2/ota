import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/repositories/apply_promo_repository_impl.dart';

abstract class ApplyPromoUseCases {
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain);
}

class ApplyPromoUseCasesImpl implements ApplyPromoUseCases {
  ApplyPromoRepository? applyPromoRepository;

  ApplyPromoUseCasesImpl({ApplyPromoRepository? repository}) {
    if (repository == null) {
      applyPromoRepository = ApplyPromoRepositoryImpl();
    } else {
      applyPromoRepository = repository;
    }
  }

  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return await applyPromoRepository?.applyPromoCode(applyPromoArgumentDomain);
  }
}
