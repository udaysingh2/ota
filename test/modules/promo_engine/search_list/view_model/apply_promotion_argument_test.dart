import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/apply_promotion_argument.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

void main() {
  PublicPromotion publicPromotion = PublicPromotion(
      promotionId: 1,
      promotionName: '',
      shortDescription: '',
      discount: 0,
      maximumDiscount: 0,
      discountType: '',
      discountFor: '',
      promotionLink: '',
      promotionType: '',
      iconUrl: '',
      voucherCode: '',
      promotionCode: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      applicationKey: '');
  test(
    'Apply Promo Argument Tests',
    () async {
      ApplyPromoArgument applyPromoArgument = ApplyPromoArgument(
        merchantId: 'merchantId',
        bookingUrn: 'bookingUrn',
        appliedPromo: publicPromotion,
      );

      applyPromoArgument.toApplyPromoArgumentDomain();
      expect(applyPromoArgument.bookingUrn, 'bookingUrn');
    },
  );
}
