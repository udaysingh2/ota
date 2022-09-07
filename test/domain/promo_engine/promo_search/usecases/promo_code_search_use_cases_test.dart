import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/promo_search/data_sources/promo_code_search_remote_data_source.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/repositories/promo_code_search_repository_impl.dart';
import 'package:ota/domain/promo_engine/promo_search/usecases/promo_code_search_use_cases.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedPromoCodeSearchUseCase implements PromoCodeSearchRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  PromoCodeSearchRemoteDataSource? promoCodeSearchRemoteDataSource;

  @override
  Future<Either<Failure, PromoCodeSearchModelDomain>> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) {
    Map<String, dynamic> map =
        json.decode(fixture("promo_engine/promo_code_search_mock.json"));
    return Future.value(Right(PromoCodeSearchModelDomain.fromMap(map)));
  }
}

void main() {
  PromoCodeSearchUseCases? useCases;

  setUpAll(() async {
    useCases = PromoCodeSearchUseCasesImpl(
      repository: _MockedPromoCodeSearchUseCase(),
    );
  });

  test('class PromoCodeSearchUseCases If repository == NULL test', () async {
    PromoCodeSearchUseCases? useCases =
        PromoCodeSearchUseCasesImpl(repository: null);

    final result = await useCases
        .searchPromoCode(PromoCodeArgumentDomain(applicationKey: ''));

    expect(result?.isLeft, true);
  });

  test('class PromoCodeSearchUseCases If repository != NULL test', () async {
    final result = await useCases!
        .searchPromoCode(PromoCodeArgumentDomain(applicationKey: ''));

    final data = result!.right.searchPromoCode?.data;

    expect(data?.promotionId, 1);
    expect(data?.promotionName, 'RBH Special');
    expect(data?.promotionCode, 'RBH50');
    expect(data?.shortDescription, 'ส่วนลดมูลค่า 50 บาท');
    expect(data?.promotionLink, 'scbeasy://payments/creditcard/review/id/4567');
    expect(data?.discount, 50.0);
    expect(data?.maximumDiscount, 100.0);
    expect(data?.discountType, 'PERCENT');
  });
}
