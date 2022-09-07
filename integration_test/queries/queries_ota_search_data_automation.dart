import '../models/ota_search_data_argument_automation.dart';

class QueriesOtaSearchAutomation {
  static String getOtaSearchData(OtaSearchDataArgumentAutomation argument) {
    return '''
        mutation {
          getOtaSearchResult(searchRequest : ${argument.toMap()}) 
          {
            data {
              hotel {
                hotelList {
                  sortSequence
                  hotelId
                  hotelName
                  hotelImage
                  rating
                  address
                  totalPrice
                  pricePerNight
                  ratingTitle
                  reviewText
                  offerPercent
                  score
                  discount
                }
                filter {
                  minPrice
                  maxPrice
                  rating
                  promotion
                  reviewScore
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
