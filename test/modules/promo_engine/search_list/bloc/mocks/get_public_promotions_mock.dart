import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/usecases/public_promotion_usecases.dart';

class GetPublicPromotionsMocks extends PublicPromotionUseCasesImpl {
  @override
  Future<Either<Failure, PublicPromotionModelDomain>?> getPublicPromotionData(
      PublicPromotionArgumentDomain argumentDomain) async {
    PromotionList promotion = PromotionList(
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
    );
    List<PromotionList>? promotionList = [];
    promotionList.add(promotion);
    return Right(
      PublicPromotionModelDomain(
        getAvailablePublicPromotions: GetAvailablePublicPromotions(
            data: Data(
                pagination: Pagination(
                    currentPage: 0,
                    pageSize: 20,
                    hasNextPage: true,
                    hasPreviousPage: false),
                promotionList: promotionList),
            status: Status(code: "1000", header: "", description: "")),
      ),
    );
  }
}

class GetPublicPromotionsEmptyMocks extends PublicPromotionUseCasesImpl {
  @override
  Future<Either<Failure, PublicPromotionModelDomain>?> getPublicPromotionData(
      PublicPromotionArgumentDomain argumentDomain) async {
    List<PromotionList>? promotionList = [];
    return Right(
      PublicPromotionModelDomain(
        getAvailablePublicPromotions: GetAvailablePublicPromotions(
            data: Data(
                pagination: Pagination(
                    currentPage: 0,
                    pageSize: 20,
                    hasNextPage: true,
                    hasPreviousPage: false),
                promotionList: promotionList),
            status: Status(code: "1000", header: "", description: "")),
      ),
    );
  }
}

class GetPublicPromotionsNullMocks extends PublicPromotionUseCasesImpl {
  @override
  Future<Either<Failure, PublicPromotionModelDomain>?> getPublicPromotionData(
      PublicPromotionArgumentDomain argumentDomain) async {
    List<PromotionList>? promotionList;
    return Right(
      PublicPromotionModelDomain(
        getAvailablePublicPromotions: GetAvailablePublicPromotions(
            data: Data(
                pagination: Pagination(
                    currentPage: 0,
                    pageSize: 20,
                    hasNextPage: true,
                    hasPreviousPage: false),
                promotionList: promotionList),
            status: Status(code: "1000", header: "", description: "")),
      ),
    );
  }
}

class GetPublicPromoImplFailureMock extends PublicPromotionUseCasesImpl {
  @override
  Future<Either<Failure, PublicPromotionModelDomain>?> getPublicPromotionData(
      PublicPromotionArgumentDomain argumentDomain) async {
    return Left(InternetFailure());
  }
}
