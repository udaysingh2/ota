import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/data_sources/remove_promo_code_remote_data_sources.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/repositories/remove_promo_code_repository_impl.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/usecases/remove_promo_code_use_cases.dart';

import '../../../../mocks/fixture_reader.dart';

class _MockedRemovePromoCodeUseCase implements RemovePromoCodeRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  RemovePromoCodeRemoteDataSource? removePromoCodeRemoteDataSource;

  @override
  Future<Either<Failure, RemovePromoCodeModelDomain>?> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    Map<String, dynamic> map =
        json.decode(fixture("promo_engine/remove_promo_code_mock.json"));
    return Future.value(Right(RemovePromoCodeModelDomain.fromMap(map)));
  }
}

void main() {
  RemovePromoCodeUseCases? useCases;

  setUpAll(() async {
    useCases = RemovePromoCodeUseCasesImpl(
      repository: _MockedRemovePromoCodeUseCase(),
    );
  });

  test('class RemovePromoCodeUseCases If repository == NULL test', () async {
    RemovePromoCodeUseCases? useCases =
        RemovePromoCodeUseCasesImpl(repository: null);

    final result = await useCases
        .getRemovePromoCodeData(RemovePromoCodeArgumentDomain(bookingUrn: ''));

    expect(result?.isLeft, true);
  });

  test('class RemovePromoCodeUseCases If repository != NULL test', () async {
    final result = await useCases!
        .getRemovePromoCodeData(RemovePromoCodeArgumentDomain(bookingUrn: ''));

    final data = result!.right.removePromoCode?.data;

    expect(data?.removed, true);
    expect(data?.priceDetails?.totalAmount, 400.0);
    expect(data?.priceDetails?.addonPrice, 200.0);
    expect(data?.priceDetails?.orderPrice, 200.0);
  });
}
