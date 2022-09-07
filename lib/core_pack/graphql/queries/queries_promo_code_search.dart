import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';

class QueriesPromoSearch {
  static String searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) {
    return '''
      query{
      searchPromoCode(applicationKey: "${promoCodeArgumentDomain.applicationKey}", 
      voucherCode: "${promoCodeArgumentDomain.voucherCode}",
      bookingUrn :"${promoCodeArgumentDomain.bookingUrn}"){
    data {
      promotionId
      promotionName
      shortDescription
      discount
      maximumDiscount
      discountType
      discountFor
      promotionLink
      promotionType
      iconUrl
      voucherCode
      promotionCode
      startDate
      endDate
      applicationKey
    }
    status{
      code
      header
      description
    }
  }
}
    ''';
  }
}
