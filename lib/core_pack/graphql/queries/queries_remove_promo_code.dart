import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';

class QueriesRemovePromoCode {
  static String removePromoCodeData(RemovePromoCodeArgumentDomain argument) {
    return '''mutation RemovePromoCode {
  removePromoCode(
    removePromoRequest: { 
      bookingUrn: "${argument.bookingUrn}"
    }
  ) {
    data {
      removed
      priceDetails {
        orderPrice
        addonPrice
        totalAmount
      }
    }
    status {
      code
      header
      description
    }
  }
}
''';
  }
}
