import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';

class QueriesPromoApply {
  static String applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) {
    return '''
      mutation 
       ApplyPromoCode {
        applyPromoCode(
          applyPromoCodeRequest: ${applyPromoArgumentDomain.toMap()}
                
        ) {
          data {
            bookingUrn
            priceDetails {
              effectiveDiscount
              orderPrice
              addonPrice
              billingAmount
              totalAmount
            }
          }
          status {
            code
            header
            description
            errors
          }
        }
      }
    ''';
  }
}
