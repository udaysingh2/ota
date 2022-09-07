import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_argument_domain.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_user_information_argument_domain.dart';

class QueriesTourReviewReservationData {
  static String getTourReviewReservationData(
      TourReviewReservationArgumentDomain argument) {
    return '''
            query {
              getTourBookingInitiate(
                tourBookingInitiate: ${argument.toMap()}
              ) {
                data {
                  bookingUrn
                  tourName
                  tourImage
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
                  tourDetails {
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
                      inclusions {
                        highlights {
                          key
                          value
                        }
                        all
                      }
                      exclusions
                      conditions
                      schedule
                      meetingPoint
                      cancellationPolicy
                      shuttle
                      adultPrice
                      childPrice
                      adultPaxId
   		  			        childPaxId
                      childInfo {
                        minAge
                        maxAge
                      }
                      currency
                      refCode
                      serviceId
                      rateKey
                      durationText
                      duration
                      zoneId
                      requireInfo {
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

  static String getContactInformationData(
      ToursContactInformationArgumentDomain argument) {
    return '''
      query {
       getTourDetails(tourDetailsRequest: 
         }
        ) 
        {
        data {
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
              exclusions
              conditions
              schedule
              meetingPoint
              shuttle
              cancellationPolicy
              adultPrice
              childPrice
              childInfo{
                minAge
                maxAge
              }
              currency
              refCode
              serviceId
              serviceType
              rateKey
              availableChildSeats
              minimumChildSeats
              availableAdultSeats
              minimumAdultSeats
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
}
