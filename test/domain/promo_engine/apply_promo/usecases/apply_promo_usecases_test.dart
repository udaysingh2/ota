import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_mock_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/repositories/apply_promo_repository_impl.dart';
import 'package:ota/domain/promo_engine/apply_promo/usecases/apply_promo_use_cases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  ApplyPromoUseCases? applyPromoUseCases;
  ApplyPromoArgumentDomain applyPromoArgumentDomain = ApplyPromoArgumentDomain(
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
    applyPromoUseCases = ApplyPromoUseCasesImpl(
        repository: ApplyPromoRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: ApplyPromoMockDataSourceImpl()));
  });
  test('Apply Promo UseCases ', () async {
    /// Consent user cases impl
    final applyPromoResult =
        await applyPromoUseCases?.applyPromoCode(applyPromoArgumentDomain);

    /// Get model from mock data.
    final ApplyPromoModelDomain model = applyPromoResult!.right;

    expect(model.applyPromoCode != null, true);
  });
}
