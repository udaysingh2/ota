import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/repositories/promo_code_search_repository_impl.dart';

abstract class PromoCodeSearchUseCases {
  Future<Either<Failure, PromoCodeSearchModelDomain>?> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain);
}

class PromoCodeSearchUseCasesImpl implements PromoCodeSearchUseCases {
  PromoCodeSearchRepository? promoCodeSearchRepository;

  PromoCodeSearchUseCasesImpl({PromoCodeSearchRepository? repository}) {
    if (repository == null) {
      promoCodeSearchRepository = PromoCodeSearchRepositoryImpl();
    } else {
      promoCodeSearchRepository = repository;
    }
  }

  @override
  Future<Either<Failure, PromoCodeSearchModelDomain>?> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) async {
    return await promoCodeSearchRepository
        ?.searchPromoCode(promoCodeArgumentDomain);
  }
}
