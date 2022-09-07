import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

class ApplyPromoArgument {
  String bookingUrn;
  PublicPromotion appliedPromo;
  String merchantId;

  ApplyPromoArgument({
    required this.bookingUrn,
    required this.appliedPromo,
    required this.merchantId,
  });

  ApplyPromoArgumentDomain toApplyPromoArgumentDomain() {
    return ApplyPromoArgumentDomain(
      bookingUrn: bookingUrn,
      promotionDetailsModel: appliedPromo.toPromoDetailsModel(merchantId),
    );
  }
}
