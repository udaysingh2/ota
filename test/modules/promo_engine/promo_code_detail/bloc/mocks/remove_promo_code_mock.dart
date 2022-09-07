import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/usecases/remove_promo_code_use_cases.dart';

class RemovePromoCodeImplSuccessMock extends RemovePromoCodeUseCasesImpl {
  @override
  Future<Either<Failure, RemovePromoCodeModelDomain>?> getRemovePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    return Right(
      RemovePromoCodeModelDomain(
        removePromoCode: RemovePromoCode(
          data: RemovePromoCodeData(
            removed: true,
            priceDetails: PriceDetails(
              totalAmount: 1000.0,
              addonPrice: 300.0,
              orderPrice: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}

class RemovePromoCodeImplResultEmptyMock extends RemovePromoCodeUseCasesImpl {
  @override
  Future<Either<Failure, RemovePromoCodeModelDomain>?> getRemovePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    return Right(
      RemovePromoCodeModelDomain(removePromoCode: null),
    );
  }
}

class RemovePromoCodeImplFailureMock extends RemovePromoCodeUseCasesImpl {
  @override
  Future<Either<Failure, RemovePromoCodeModelDomain>?> getRemovePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    return Left(InternetFailure());
  }
}
