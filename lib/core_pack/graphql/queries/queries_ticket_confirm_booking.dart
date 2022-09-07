import 'package:ota/domain/tours/confirm_booking/models/confirm_booking_argument_domain.dart';

class QueriesTicketConfirmBookingData {
  static String getTicketConfirmBookingData(
      ConfirmBookingArgumentDomain argument) {
    return '''
query {
  getTicketBookingConfirmation(
    ticketBookingConfirmation: ${argument.toMap()}
  ) {
    data {
      bookingUrn
      ticketId
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
          all
        }
        cancellationPolicy
        ticketTypes {
          paxId
          name
          price
          noOfTickets
        }
        duration
        durationText
      }
      totalAmount
      totalFees
      totalTaxes
      totalDiscount
      noOfDays
      startTimeAMPM
      customerInfo {
        firstName
        lastName
        email
        phoneNumber
      }
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
