import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';

class QueriesPublicPromotion {
  static String getPublicPromotionData(PublicPromotionArgumentDomain argument) {
    return '''
          mutation GetAvailablePublicPromotions {
  getAvailablePublicPromotions(
    publicPromotionsRequest: { 
      applicationKey: "${argument.applicationKey}", 
      pagingOffset: ${argument.pagingOffset} }
  ) {
    data {
      pagination {
        currentPage
        pageSize
        hasNextPage
        hasPreviousPage
      }
      promotionList {
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
    }
    status {
      code
      header
      description
      errors
    }
  }
}''';
  }
}
