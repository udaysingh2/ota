import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart';

class QueriesTourSearchResult {
  static String getTourSearchResultData(
      TourSearchResultArgumentDomain argument) {
    return '''
      mutation {
        getTourAndTicketSearchResult(
          tourAndTicketSearchRequest: ${argument.toMap()}
        ) {
          data {
            location
            tourAndTicketActivityList {
              id
              name
              styleName
              locationName
              cityId
              cityName
              countryId
              countryName
              imageUrl
              startPrice
              promotionText_line1
              promotionText_line2
              capsulePromotion {
		            name
				        code
			        }
            },
         filter{ 
            minPrice,
            maxPrice,
            styleName
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
