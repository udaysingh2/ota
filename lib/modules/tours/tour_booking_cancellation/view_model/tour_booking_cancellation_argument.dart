import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_argument_model.dart';

class TourBookingCancellationArgument {
  final String confirmNo;
  final String reason;
  TourBookingCancellationArgument(
      {required this.confirmNo, required this.reason});
  TourBookingCancellationArgumentDomain toTourBookingCancellationDomainArgument() {
    return TourBookingCancellationArgumentDomain(
      confirmationNo: confirmNo,
      cancellationReason: reason,
    );
  }
}
