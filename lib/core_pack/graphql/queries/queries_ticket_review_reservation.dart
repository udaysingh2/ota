import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_argument_domain.dart';

class QueriesTicketReviewReservationData {
  static String getTicketReviewReservationData(
      TicketReviewReservationArgumentDomain argument) {
    return '''
      query {
        getTicketBookingInitiateDetails(
          ticketBookingInitiateRequest: {
            cityId: "${argument.cityId}"
            countryId: "${argument.countryId}"
            bookingDate: "${argument.bookingDate}"
            refCode: "${argument.refCode}"
            currency: "${argument.currency}"
            rateKey: "${argument.rateKey}"
            serviceId: "${argument.serviceId}"
            price: ${argument.price}
            ticketId: "${argument.ticketId}"
            ticketTypes: ${argument.ticketPackageReservationArgument.map((result) => result.toMap()).toList()}
            timeOfDay: "${argument.timeOfDay}"
            startTime: "${argument.startTime}"
            serviceType: "${argument.serviceType}"
            ticketPackageFilter:${argument.ticketPackageFilter.toMap()}
          }
        ) {
          data {
            bookingUrn
            totalPrice
            ticketName
            ticketImage
            promotionList {
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
            ticketDetails {
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
                shuttle
                cancellationPolicy
                childInfo {
                  minAge
                  maxAge
                }
                ticketTypes {
                  paxId
                  name
                  price
                  noOfTickets
                  minimum
                  available
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
}
