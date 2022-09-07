import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';

class QueriesHotelDetailInterest {
  static String getHotelInterest(HotelDetailInterestDataArgument argument) {
    return '''mutation {
  getHotelsYouMayLike(
    hotelsYouMayLikeRequest: ${argument.toGraphqlString()}
  ) {
    data {
      hotelList {
        hotelId
        hotelName
        image
        rating
        address {
          address
          locationId
          locationName
          cityId
          cityName
          countryId
          countryName
        }
        infoTechPromotion
        totalPrice
        pricePerNight
        adminPromotion {
          adminPromotionLine1
          adminPromotionLine2
        }
        capsulePromotion{
           name 
           code 
        }
        review {
          score
          numReview
          description
        }
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
