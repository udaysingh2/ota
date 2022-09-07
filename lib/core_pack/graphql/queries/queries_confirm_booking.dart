import 'package:ota/domain/confirm_booking/models/argument_data_model.dart';

class QueriesConfirmBooking {
  static String getHotelConfirmBookingData(
      HotelConfirmBookingArgumentModelDomain argument) {
    return '''
        mutation {
          BookingConfirmation(BookingConfirmationRequest: ${argument.toMap()})
          {
            data {
              bookingUrn
              totalAmount
              totalFees
              totalTaxes
              totalDiscount
              status
              hotelBookingDetails {
                hotelId
                cityId
                countryId
                checkInDate
                checkOutDate
                roomCode
                roomCategory
                requestedRoomDetails {
                  adults
                  children
                  childAge1
                  childAge2
                }
                roomDetails {
                  mealType
                  roomImage
                  roomCategories {
                    noOfRoomsAndName
                    roomName
                    roomType
                    noOfRooms
                  }
                  facilities {
                    key
                    value
                  }
                  hotelBenefits {
                    shortDescription
                    longDescription
                  }
                  cancellationPolicy {
                    days
                    cancellationDaysDescription
                    cancellationChargeDescription
                    cancellationStatus
                  }
                  totalPrice
                  perNightPrice
                  numberOfNights
                  hotelName
                  hotelImage
                  discountPercent
                  nightPriceBeforeDiscount
                }
                addOnServices {
                  price
                  image
                  description
                  hotelServiceId
                  hotelServiceName
                  serviceDate
                  quantity
                  isFlightRequired
                }   
                additionalNeedsTxt
                fees
                taxes
                discount
                freeFoodDelivery
              }
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
              currency
              locale
              guestInfo {
                firstName
                lastName
                title
              }
              customerInfo {
                firstName
                lastName
                membershipId
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
