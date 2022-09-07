import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';

class QueriesCarDeatil {
  static String getCarDetailData(CarDetailDomainArgumentModel argument) {
    return '''
    query { getCarRentalDetails(
  carRentalDetailsRequest: {
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
  }) {
    data {
      carInfo {
        brand
        crafttype
        images {
          thumb
          full
        }
        name
      }
      carDetail {
        allowLateReturn
        id
        supplier {
          id
          name
          logo {
            url
          }
        }
        car {
          id
          name
          brand
          crafttype
          seatNbr
          doorNbr
          bagLargeNbr
          bagSmallNbr
          engine
          gear
          facilities
          images {
            thumb
            full
          }
          year
          color
          fuelType
          description
          generalInfo
          conditionInfo
        }
        toDate
        fromDate
        pickupCounter {
          name
          id
          address
          cityName
          locationId
          latitude
          longitude
          opentime
          locationName
          closetime
          description
        }
        currency
        isIncludeDriver
        isPromotion
        includesInfo
        description
        carRentalConditionsInfo
        pickupConditionsInfo
        rateKey
        refCode
        totalPrice
        pricePerDay
        returnExtraCharge
        termsAndCondition
        returnCounter {
          id
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
        promotionList {
                  productId
                  productType
                  promotionType
                  promotionCode
                  line1
                  line2
                  title
                  description
                  web
                  iconImage
                  bannerDescDisplay
                }
              }
            }
    status {
      code
      header
    }
  }
}
    ''';
  }
}
