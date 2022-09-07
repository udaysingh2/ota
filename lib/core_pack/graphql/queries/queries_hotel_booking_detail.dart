import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_details_argument_model.dart';

import '../../../core/query_names.dart';

class QueriesHotelBookingDetail {
  static String getHotelBookingDetailData(
      HotelBookingDetailArgumentDomain argument) {
    return '''
mutation  {
  ${QueryNames.shared.bookingDetails}(
    bookingDetailsRequest: {
      confirmationNo: "${argument.confirmationNo}"
      bookingUrn: "${argument.bookingUrn}"
    }
  ) {
    data {
      bookingStatus
      bookingStatusCode
      bookingId
      bookingUrn
      referenceId
      bookingType
      activityStatus
           promotion {
            promotionId
            promotionName
            shortDescription
            discount
            maximumDiscount
            discountType
            discountFor
            promotionLink
            promotionType
            iconUrl
            voucherCode
            promotionCode
            startDate
            endDate
            applicationKey 
          }
	  priceDetails {
            effectiveDiscount
            orderPrice
            addonPrice
            billingAmount
            totalAmount
      }
      hotelBookingDetail {
        totalPrice
        hotelDetails {
          cityId
          hotelId
          name
          countryId
          imageUrl
          checkInDate
          checkOutDate
          address
          phoneNumber
          rating
          latitude
          longitude
          roomInfo {
            roomOfferName
            promoteFlag
            dimension
            doubleBedFlag
            twinBedFlag
            queenBedflag
            smorkingFlag
            nonSmorkingFlag
            noWindowFlag
            balconyFlag
            wifiFlag
            maxPaxNbr
            roomFacilities {
              code
              name
            }
          }
          freeFoodDelivery
          roomDetails {
            type
            price
            name
            noOfRoom
            noOfAdult
            noOfChild
            priceOfRoomWithChildMeal
            noOfRoomsAndName
            roomCode
            roomCatName

          }
          facilities {
            key
            value
          }
          guestInfo {
            firstName
            lastName
            title
          }
          addOnServices {
            serviceName
            serviceDate
            noOfItem
            price
          }
          cancellationPolicy {
            days
            cancellationDaysDescription
            cancellationChargeDescription
            cancellationStatus
          }
          totalNights
          totalRooms
          promotion {
            productId
            productType
            promotionType
            promotionCode
            line1
            line2
            startDate
            endDate
          }
          hotelBenefits{
            topic
            shortDescription
            longDescription
            categoryId
            categoryName
          }
        }
        netPrice
        perNightPrice
        addonPrice
        discount
        amountAdminfee
        amountCancelCharge
        payment {
          type
          name
          amount
          cardType
          cardNo
          cardNickName
        }
        cancellationDate
        cancellationReason
        totalRefundAmount
        confirmationDate
        paymentStatus
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
    }
    status {
      description
      header
      code
    }
    
  }
}
 ''';
  }
}
