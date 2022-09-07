import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';

class QueriesHotelBookingCancellation {
  static String getHotelBookingCancellation(
      HotelBookingCancellationArgument argument) {
    return """
  mutation{
  rejectBooking(
    RejectBookingRequest: {
      confirmNo: "${argument.confirmNo}",
      cancellationReason: "${argument.reason}"
    }
  )
  {
    data{
    actionStatus
	  cancellationDate
	  totalAmount
	  refund{
	  reservationCancellationFee
	  processingFee
	  refundAmount
	  }
    }
    status{
      code
      header
      description
    }
  }
}
""";
  }
}
