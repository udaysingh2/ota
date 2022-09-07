import '../../../domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';

class QueriesCarReservation {
  static String getCarReservationData(
      CarReservationDomainArgumentModel argument) {
    return '''
mutation GetCarInitiateBookingResponse {
  getCarInitiateBookingResponse(initiateCarBookingRequest: {
          carId: "${argument.carId}",
          pickupLocation:"${argument.pickupLocationId}",
          returnLocation:"${argument.returnLocationId}",
          pickupDate: "${argument.pickupDate}",
          returnDate: "${argument.returnDate}",
          supplierId : "${argument.supplierId}",
          includeDriver: "${argument.includeDriver}",
          residenceCountry: "${argument.residenceCountry}",
          currency: "${argument.currency}",
          rentalType: "${argument.rentalType}",
          age: ${argument.age},
          pickupCounter: "${argument.pickupCounter}",
          returnCounter: "${argument.returnCounter}",
          rateKey: "${argument.rateKey}",
          refCode: "${argument.refCode}" }) 
  {
    data {
      bookingUrn
      id
      allowLateReturn
      rentalDays
      image
      fromDate
      toDate
      currency
      isIncludeDriver
      isPromotion
      generalInfo
      conditionInfo
      description
      includeDriver
      promotion
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
      extraCharges {
        id
        car_rate_id
        fromDate
        toDate
        price
        isCompulsory
        chargeType
        description
        extraChargeGroup {
          id
          name
          description
        }
      }
      cancellationPolicy {
        cancelDays
        message
      }
      returnCounter {
        id
        name
        address
        countryId
        countryName
        cityId
        cityName
        locationId
        locationName
        latitude
        longitude
        opentime
        closetime
        description
      }
      ratePerDays {
        ratePerDay
        rateKey
        refCode
        minDay
        minAge
        maxAge
        totalDays
        isMileageLimit
        mileageDescription
        conditionInfo
        returnCounter
        returnExtraCharge
        totalDaysExtraCharge
        extraChargesCompulsory
        total
      }
      pickupCounter {
        id
        name
        address
        countryId
        countryName
        cityId
        cityName
        locationId
        locationName
        latitude
        longitude
        opentime
        closetime
        description
      }
      supplier {
        id
        name
        logo {
          url
          title
          alt
        }
      }
      car {
        id
        name
        nameBy
        brand
        crafttype
        seatNbr
        doorNbr
        bagLargeNbr
        bagSmallNbr
        engine
        gear
        year
        color
        fuelType
        licensePlateNbr
        description
        generalInfo
        conditionInfo
        facilities
      }
    }
    status {
      code
      header
      description
      errors
    }
  }
}
     ''';
  }
}
