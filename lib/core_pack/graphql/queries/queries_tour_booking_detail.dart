import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_argument_model.dart';

import '../../../core/query_names.dart';

class QueriesTourBookingDetail {
  static String getTourBookingDetailData(
      TourBookingDetailArgumentDomain argument) {
    return '''
mutation {
  ${QueryNames.shared.getTourBookingDetail}(
    bookingDetailsRequest: {
	  bookingId:"${argument.bookingId}",
	  bookingUrn:"${argument.bookingUrn}",
	  bookingType:"${argument.bookingType}"
    }
  ) {
    data {
      bookingStatus
      activityStatus
      bookingUrn
      bookingId
      orderId
      bookingType
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
      tourBookingDetail {
        name
        imageUrl
        category
        location
        packageDetail {
          packageName
          inclusions {
            highlights {
              key
              value
            }
            all
          }
          cancellationPolicy
          durationText
          exclusions
          conditions
          shuttle
          meetingPoint
          meetingPointLatitude
          meetingPointLongitude
          schedule
          childInfo {
            minAge
            maxAge
          }
        }
        information {
          description
          conditions
          howToUse
          openTime
          closeTime
        }
        price {
          adultPrice
          childPrice
        }
        bookingDate
        confirmationDate
        cancellationDate
        cancellationCharge
        cancellationReason
        totalRefundAmount
        noOfDays
        child
        adults
        participantInfo {
          name
          surname
          weight
          dateOfBirth
          passportCountry
          passportNumber
          passportCountryIssue
          expiryDate
        }
        providerName
        supplierContact
        paymentStatus
        netPrice
        totalPrice
        discount
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
        bookingCancellable
        payment {
                amount
                cardNickName
                cardNo
                cardType
                type
                name
            }
        tourId
        countryId
        cityId
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
