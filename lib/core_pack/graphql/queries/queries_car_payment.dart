import '../../../domain/car_rental/car_payment/models/car_payment_argument_model.dart';

class QueriesCarPayment {
  static String getCarPaymentData(CarPaymentDomainArgumentModel argument) {
    return '''
    mutation{
  saveCarBookingConfirmationDetails(carBookingConfirmationRequest: ${argument.toMap()}) {
    status {
    code
    header
    description
    }
    data {
      bookingUrn,
      pricePerDay,
      carRentalTotalPrice,
      extrasOnlinePrice,
      extrasOfflinePrice,
      returnExtraCharge,
      addOnServices {
        chargeType
        description 
        serviceId  
        isCompulsory
        name 
        price
        quantity
      }
      cancellationPolicy {
        cancelDays 
        message 
      }
      currency
      discount
      isNonRefund
    }  
  }
}
     ''';
  }
}
