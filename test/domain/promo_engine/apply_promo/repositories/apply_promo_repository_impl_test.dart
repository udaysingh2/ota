import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_mock_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_remote_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/repositories/apply_promo_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class ApplyPromoDataSourceFailureMock implements ApplyPromoRemoteDataSource {
  Future<ApplyPromoModelDomain> getPromoCards(ApplyPromoModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<ApplyPromoModelDomain> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) {
    throw UnimplementedError();
  }
}

void main() {
  ApplyPromoRepository? applyPromoRepositoryMock;
  ApplyPromoRepository? applyPromoRepositoryServerException;
  ApplyPromoArgumentDomain argument = ApplyPromoArgumentDomain(
      bookingUrn: "",
      promotionDetailsModel: PromotionDetailsModel(
          applicationKey: "",
          discount: 0,
          discountFor: "",
          discountType: "",
          promotionCode: "",
          promotionId: 0,
          promotionLink: "",
          promotionType: "",
          shortDescription: "",
          promotionName: "",
          voucherCode: "",
          maximumDiscount: 0,
          iconUrl: "",
          merchantId: "",
          endDate: DateTime.now(),
          startDate: DateTime.now()));

  setUpAll(() async {
    applyPromoRepositoryMock = ApplyPromoRepositoryImpl();

    applyPromoRepositoryMock = ApplyPromoRepositoryImpl(
        remoteDataSource: ApplyPromoMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    applyPromoRepositoryServerException = ApplyPromoRepositoryImpl(
        remoteDataSource: ApplyPromoMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test("Apply Promo Repository" 'With Success response', () async {
    final result = await applyPromoRepositoryMock!.applyPromoCode(argument);
    final ApplyPromoModelDomain promoData = result.right;
    expect(promoData.applyPromoCode == null, false);
  });

  test("Apply Promo Repository" 'With Server Exception response data',
      () async {
    final result =
        await applyPromoRepositoryServerException!.applyPromoCode(argument);
    expect(result.isLeft, true);
  });
}
