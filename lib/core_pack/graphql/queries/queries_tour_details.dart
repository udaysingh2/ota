import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/domain/tours/details/models/tour_package_details_argument_domain.dart';

class QueriesTourDetailsData {
  static String getTourDetailsData(TourDetailArgumentDomain argument) {
    return '''
      query {
       getTourDetails(tourDetailsRequest: {
          countryId: "${argument.countryId}"
          cityId: "${argument.cityId}"
          tourId: "${argument.tourId}"
          tourDate: "${argument.tourDate}"
         }
        ) 
        {
        data {
          promotionList
            {
              productType
              promotionCode
              title
              description
              web
              iconImage
              bannerDescDisplay
              line1
              line2
              promotionType
              productId
            }
          tour{
            id
            name
            image
            location
            category
            information {
              description
              conditions
              howToUse
              providerName
              openTime
              closeTime
            }
            packages {       
              name  
              inclusions{
              highlights{  
                  key
                  value
                }
                all
              }
              style{
					    id		
					    name
					    }
              exclusions
              conditions
              schedule
              meetingPoint
              shuttle
              cancellationPolicy
              adultPrice
              childPrice
              totalPrice
              childInfo{
                minAge
                maxAge
                description
              }
              currency
              refCode
              serviceId
              serviceType
              timeOfDay
              startTime
              rateKey
              availableSeats
              minimumSeats
              durationText
              zoneId
              requireInfo{
                weight
                allName
                guestName
                passportId
                dateOfBirth
                passportCountry
                passportValidDate
                passportCountryIssue
                
              }
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

  static String getPackageDetailsData(
      TourPackageDetailsArgumentDomain argument) {
    return '''
    query {
     getTourDetails(tourDetailsRequest: ${argument.toMap()}
  ) 
 {
		data {
      promotionList
      {
        productType
        promotionCode
        title
        description
        web
        iconImage
      }
			tour{
				id
				name
				image
				location
				category
				information {
					description
					conditions
					howToUse
					providerName
					openTime
					closeTime
				}
				packages {       
					name
					inclusions{
					highlights{  
						  key
						  value
						}
						all
					}
					style{
					  id
					  name
					 }
					exclusions
					conditions
					schedule
					meetingPoint
					shuttle
					cancellationPolicy
					adultPrice
					childPrice
					totalPrice
					childInfo{
						minAge
						maxAge
					}
					currency
					refCode
					serviceId
					serviceType
					timeOfDay
          startTime
					rateKey
					availableSeats
          minimumSeats
					durationText
					duration
					zoneId
					requireInfo{
						weight
						allName
						guestName
						passportId
						dateOfBirth
						passportCountry
						passportValidDate
						passportCountryIssue
						
					}
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
