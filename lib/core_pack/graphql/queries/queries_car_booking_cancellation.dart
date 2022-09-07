import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';

class QueriesCarBookingCancellation {
  static String getCarBookingCancellation(
      CarBookingCancellationArgument argument) {
    return """
    mutation{
    getCarRejectBookingResponse(
        rejectCarBookingRequest: {
          confirmNo: "${argument.confirmNo}",
          cancellationReason: "${argument.reason}"
        }
      )
     {
    data{
    actionStatus 
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
