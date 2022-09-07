import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/repositories/public_promotion_repository_impl.dart';

/// Interface for ServiceCard use cases.
abstract class PublicPromotionUseCases {
  Future<Either<Failure, PublicPromotionModelDomain?>?> getPublicPromotionData(
      PublicPromotionArgumentDomain argument);
}

class PublicPromotionUseCasesImpl implements PublicPromotionUseCases {
  PublicPromotionRepository? publicPromotionRepository;

  /// Dependence injection via constructor
  PublicPromotionUseCasesImpl({PublicPromotionRepository? repository}) {
    if (repository == null) {
      publicPromotionRepository = PublicPromotionRepositoryImpl();
    } else {
      publicPromotionRepository = repository;
    }
  }

  @override
  Future<Either<Failure, PublicPromotionModelDomain?>?> getPublicPromotionData(
      PublicPromotionArgumentDomain argument) async {
    return await publicPromotionRepository?.getPublicPromotionData(argument);
  }
}
