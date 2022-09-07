import '../../../core/query_names.dart';

class QueriesCarBookingDetail {
  static String getQueriesCarBookingDetailData({
    required String bookingId,
    required String bookingUrn,
    required String bookingType,
  }) {
    return '''  
    mutation {
  ${QueryNames.shared.getCarBookingDetailData}(
    bookingDetailsRequest: {
      bookingId:"$bookingId",
	    bookingUrn:"$bookingUrn",
	    bookingType:"$bookingType"
    }
  ) {
    data {
      displayStatus
      bookingStatus
      activityStatus
      bookingUrn
      bookingId
      serviceNumber
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
       promoPriceDetails{
        effectiveDiscount
        orderPrice
        addonPrice
        billingAmount
        totalAmount
      }
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
      carBookingDetails {
        car {
          carId
          name
          brand
          images {
            thumb
            full
          }
          craftType
          seatNbr
          doorNbr
          bagLargeNbr
          bagSmallNbr
          engine
          gear
          fuelType
          year
          facilities
        }
        pickupCounter {
          counterId
          name
          address
          locationId
          locationName
          latitude
          longitude
          opentime
          closetime
          description
        }
        returnCounter {
          counterId
          name
          address
          locationId
          locationName
          latitude
          longitude
          opentime
          closetime
          description
        }
        payment {
          amount
          cardNickName
          cardNo
          cardType
          type
          name
        }
        supplier {
          id
          name
          logo {
            url
          }
        }
        driverName
        pickupDateTime
        returnDateTime
        rentalDays
        allowLateReturn
        flightNumber
        generalInfo
        conditionInfo
        includesInfo
        carRentalConditionsInfo
        pickupConditionsInfo
        extraCharges {
          serviceId
          chargeType
          description
          isCompulsory
          name
          price
          quantity
        }
        cancellationPolicy {
          cancelDays
          message
        }
        paymentStatus
        netPrice
        totalPrice
        totalPayablePrice
        extrasOnlinePrice
        extrasCounterPrice
        returnExtraCharge 
        totalDiscount
        confirmationDate
        cancellationDate
        cancellationCharge
        cancellationReason
        processingCharge
        totalRefundAmount
      }}
      status {
        code
        header
      }
    }
}
    ''';
  }
}
