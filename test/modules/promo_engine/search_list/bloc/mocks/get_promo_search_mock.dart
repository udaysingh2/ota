import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/usecases/promo_code_search_use_cases.dart';

class GetPromoSearchMock extends PromoCodeSearchUseCasesImpl {
  @override
  Future<Either<Failure, PromoCodeSearchModelDomain>?> searchPromoCode(
      PromoCodeArgumentDomain argumentDomain) async {
    return Right(
      PromoCodeSearchModelDomain(
        searchPromoCode: SearchPromoCode(
            data: PromoCodeData(
              promotionId: 1,
              promotionName: 'promotionName',
              shortDescription: 'shortDescription',
              discount: 50,
              discountType: 'discountType',
              discountFor: 'discountFor',
              promotionLink: 'promotionLink',
              promotionType: 'promotionType',
              voucherCode: 'voucherCode',
              promotionCode: 'promotionCode',
              startDate: "",
              endDate: "",
              applicationKey: 'Hotel',
            ),
            status: Status(code: "1000", header: "", description: "")),
      ),
    );
  }
}

class GetPromoSearchFailureMock extends PromoCodeSearchUseCasesImpl {
  @override
  Future<Either<Failure, PromoCodeSearchModelDomain>?> searchPromoCode(
      PromoCodeArgumentDomain argumentDomain) async {
    return Right(
      PromoCodeSearchModelDomain(
        searchPromoCode: SearchPromoCode(
            data: null,
            status: Status(code: "1000", header: "", description: "")),
      ),
    );
  }
}

class GetSearchImplFailureMock extends PromoCodeSearchUseCasesImpl {
  @override
  Future<Either<Failure, PromoCodeSearchModelDomain>?> searchPromoCode(
      PromoCodeArgumentDomain argumentDomain) async {
    return Left(InternetFailure());
  }
}
