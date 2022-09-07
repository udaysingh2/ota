import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

class PublicPromotionArgument {
  String applicationKey;
  String? voucherCode;
  String bookingUrn;
  int pageOffset;
  PublicPromotion? appliedPromo;
  String merchantId;

  PublicPromotionArgument({
    required this.applicationKey,
    this.voucherCode,
    required this.bookingUrn,
    this.pageOffset = 0,
    this.appliedPromo,
    required this.merchantId,
  });

  PublicPromotionArgumentDomain toDomainArgument() {
    return PublicPromotionArgumentDomain(
      applicationKey: applicationKey,
      pagingOffset: pageOffset,
    );
  }

  PromoCodeArgumentDomain toSearchArgument() {
    return PromoCodeArgumentDomain(
      applicationKey: applicationKey,
      bookingUrn: bookingUrn,
      voucherCode: voucherCode,
    );
  }
}
