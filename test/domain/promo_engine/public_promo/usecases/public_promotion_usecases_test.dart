import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotiom_remote_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/repositories/public_promotion_repository_impl.dart';
import 'package:ota/domain/promo_engine/public_promo/usecases/public_promotion_usecases.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedPublicPromotionUseCase implements PublicPromotionRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  PublicPromotionRemoteDataSource? availablePublicPromotionRemoteDataSource;

  @override
  Future<Either<Failure, PublicPromotionModelDomain?>> getPublicPromotionData(
      PublicPromotionArgumentDomain argument) {
    Map<String, dynamic> map =
        json.decode(fixture("promo_engine/public_promo_code_mock.json"));
    return Future.value(Right(PublicPromotionModelDomain.fromMap(map)));
  }
}

void main() {
  PublicPromotionUseCases? useCases;
  List<PromotionList> promotionList = [
    PromotionList(
      promotionId: 1,
      applicationKey: 'HOTEL',
      promotionName: "RBH Special",
      shortDescription: "ส่วนลดมูลค่า 50 บาท",
      discount: 50.00,
      maximumDiscount: 100.00,
      discountType: "PERCENT",
      discountFor: "ORDER",
      promotionLink: "scbeasy://payments/creditcard/review/id/4567",
      promotionType: "PUBLIC",
      iconUrl: "scbeasy://payments/creditcard/review/id/4567",
      voucherCode: "RBH50",
      promotionCode: "RBH50",
      startDate: "2020-07-24T08:44:39.000Z",
      endDate: "2020-07-24T08:44:39.000Z",
    ),
  ];

  setUpAll(() async {
    useCases = PublicPromotionUseCasesImpl(
      repository: _MockedPublicPromotionUseCase(),
    );
  });

  test('class PublicPromoCodeUseCases If repository == NULL test', () async {
    PublicPromotionUseCases? useCases =
        PublicPromotionUseCasesImpl(repository: null);

    final result = await useCases.getPublicPromotionData(
        PublicPromotionArgumentDomain(pagingOffset: 0, applicationKey: ''));

    expect(result?.isLeft, true);
  });

  test('class PublicPromoCodeUseCases If repository != NULL test', () async {
    final result = await useCases!.getPublicPromotionData(
        PublicPromotionArgumentDomain(applicationKey: '', pagingOffset: 0));
    final data = result!.right?.getAvailablePublicPromotions?.data;
    expect(data?.pagination?.currentPage, 0);
    expect(data?.pagination?.pageSize, 20);
    expect(data?.pagination?.hasNextPage, true);
    expect(data?.pagination?.hasPreviousPage, false);

    expect(
      data?.promotionList![0].promotionId,
      promotionList[0].promotionId,
    );
    expect(
      data?.promotionList![0].applicationKey,
      promotionList[0].applicationKey,
    );
    expect(
      data?.promotionList![0].promotionName,
      promotionList[0].promotionName,
    );
    expect(
      data?.promotionList![0].shortDescription,
      promotionList[0].shortDescription,
    );
    expect(
      data?.promotionList![0].discount,
      promotionList[0].discount,
    );
    expect(
      data?.promotionList![0].maximumDiscount,
      promotionList[0].maximumDiscount,
    );
    expect(
      data?.promotionList![0].discountType,
      promotionList[0].discountType,
    );
    expect(
      data?.promotionList![0].promotionLink,
      promotionList[0].promotionLink,
    );
    expect(
      data?.promotionList![0].promotionType,
      promotionList[0].promotionType,
    );
    expect(
      data?.promotionList![0].iconUrl,
      promotionList[0].iconUrl,
    );
    expect(
      data?.promotionList![0].voucherCode,
      promotionList[0].voucherCode,
    );
    expect(
      data?.promotionList![0].promotionCode,
      promotionList[0].promotionCode,
    );
    expect(
      data?.promotionList![0].startDate,
      promotionList[0].startDate,
    );
    expect(
      data?.promotionList![0].endDate,
      promotionList[0].endDate,
    );
  });
}
