import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';

class QueriesPaymentStatus {
  ///Change the argument model
  static String getPaymentStatus(String bookingUrn) {
    return '''
    mutation {
  paymentStatus(
    bookingUrn: "$bookingUrn"
  ) {
    data {
      paymentMethod
      paymentStatus
      paymentPhase
      phaseState
      deeplinkUrl
      callbackUrl
      errorDescription
      isFirstOrder

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

  static String getNewBookingUrn(String bookingUrn) {
    return '''
    query{
    generateNewBookingUrn(bookingUrn: "$bookingUrn"){
    data {
      newBookingUrn
    }
    status{
      code
      header
    }
  }
}
''';
  }

  static String getCarNewBookingUrn(String bookingUrn) {
    return '''
    query{
    generateNewCarBookingUrn(carBookingUrn: "$bookingUrn"){
    data {
      newBookingUrn
    }
    status{
      code
      header
    }
  }
}
''';
  }

  static String getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) {
    return '''
mutation {
  initiatePaymentV2(
    initiatePaymentRequest: ${argument.toMap()}
  ) {
    data {
      bookingUrn     
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
