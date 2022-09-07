import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';

class QueriesCarSupplier {
  static String getCarSupplierData(CarSupplierArgumentModel argument) {
    return '''        
query {
  getCarRentalSupplier(
    carRentalSupplierRequest: {
      pickupLocation: "${argument.pickupLocation}"
      returnLocation: "${argument.returnLocation}"
      pickupDate: "${argument.pickupDate}"
      returnDate: "${argument.returnDate}"
      carId: "${argument.carId}"
      includeDriver: "${argument.includeDriver}"
      currency: "${argument.currency}"
      rentalType: "${argument.rentalType}"
      age: ${argument.age}
    }
  ) {
    status {
      code
      header
    }
    data {
     supplierData {
      id
      allowLateReturn
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
        images {
          thumb
          full
        }
      }
      fromDate
      toDate
      currency
      totalPrice
      pricePerDay
      returnExtraCharge
      rateKey
      refCode
      pickupCounterId
      returnCounterId
     }
     freeFoodDelivery
     promotionList {
        productType
        promotionCode
        title
        line1
        line2
        description
        web
      }
    }
  }
}
    ''';
  }
}
