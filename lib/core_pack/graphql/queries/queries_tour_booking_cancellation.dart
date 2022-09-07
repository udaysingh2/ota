import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';

class QueriesTourBookingCancellation {
  static String getTourBookingCancellationData(
      TourBookingCancellationArgumentDomain argument) {
    return '''    
query {
  getTourBookingReject(
    tourBookingRejectRequest: {
      confirmNo: "${argument.confirmationNo}"
      cancellationReason: "${argument.cancellationReason}"
    }
  ) {
    data {
      actionStatus
      cancellationDate
      totalAmount
      refund {
        reservationCancellationFee
        processingFee
        refundAmount
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
