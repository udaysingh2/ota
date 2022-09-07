import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';

class QueriesTicketDetailsData {
  static String get(TicketDetailArgumentDomain argument) {
    String ticketDate = argument.ticketDate ??
        Helpers.getddMMMyyyy(DateTime.now().add(const Duration(days: 1)));
    return '''
        query {
          getTicketDetails(
            ticketDetailsRequest: {
               countryId: "${argument.countryId}"
                    cityId: "${argument.cityId}"
                    ticketId: "${argument.ticketId}"
                    ticketDate: "$ticketDate"
            }
          ) {
            data {
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
              ticket {
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
                  style{
                      id
                      name
                   }
                  exclusions
                  conditions
                  schedule
                  meetingPoint
                  meetingPointLatitude
                  meetingPointLongitude
                  cancellationPolicy
                  shuttle
                  childInfo {
                    minAge
                    maxAge
                    description
                  }
                  ticketTypes {
                    paxId
                    name
                    price
                    minimum
                    available
                  }
                  currency
                  refCode
                  serviceId
                  serviceType
                  timeOfDay
                  startTime
                  availableSeats
                  minimumSeats
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

  static String getTicketPackageDetail(
      TicketPackageDetailsArgumentDomain argument) {
    return '''
            query {
          getTicketDetails(
            ticketDetailsRequest: ${argument.toMap()}
          ) {
            data {
              promotionList {
                productType
                promotionCode
                title
                description
                web
              }
              ticket {
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
                  style{
                      id
                      name
                   }
                  exclusions
                  conditions
                  schedule
                  meetingPoint
                  meetingPointLatitude
                  meetingPointLongitude
                  cancellationPolicy
                  shuttle
                  childInfo {
                    minAge
                    maxAge
                    description
                  }
        
                  ticketTypes {
                    paxId
                    name
                    price
                    minimum
                    available
                  }
                  currency
                  refCode
                  serviceId
                  serviceType
                  timeOfDay
                  startTime
                  availableSeats
                  minimumSeats
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
