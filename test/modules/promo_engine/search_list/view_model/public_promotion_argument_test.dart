import 'package:flutter_test/flutter_test.dart';

import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

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
    'Public Promotion Argument Tests',
    () async {
      PublicPromotionArgument publicPromotionArgument = PublicPromotionArgument(
        merchantId: 'merchantId',
        bookingUrn: 'bookingUrn',
        appliedPromo: publicPromotion,
        applicationKey: '',
      );
      publicPromotionArgument.toDomainArgument();
      publicPromotionArgument.toSearchArgument();
      expect(publicPromotionArgument.bookingUrn, 'bookingUrn');
    },
  );
}
