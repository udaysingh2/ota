import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';

class QueriesTourConfirmBookingData {
  static String getTourConfirmBookingData(
      ConfirmBookingArgumentDomain argument) {
    return '''
            query {
              getTourBookingConfirmation(
                tourBookingConfirmation: ${argument.toMap()}
              ) {
                data {
                  bookingUrn
                  tourId
                  cityId
                  countryId
                  bookingDate
                  name
                  image
                  location
                  category
                  promotionList{
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
                  packageDetail {
                    name
                    inclusions {
                      highlights {
                        key
                        value
                      }
                    }
                    cancellationPolicy
                    durationText
                    duration
                  }
                  totalAmount
                  totalFees
                  totalTaxes
                  totalDiscount
                  noOfDays
                  startTimeAMPM
                  participantInfo {
                    paxId
                    name
                    surname
                    weight
                    dateOfBirth
                    passportCountry
                    passportNumber
                    passportCountryIssue
                    expiryDate
                  }
                  customerInfo {
                    email
                    firstName
                    lastName
                    phoneNumber
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
