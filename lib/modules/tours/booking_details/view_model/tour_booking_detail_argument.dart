import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_argument_model.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_view_model.dart';

class TourBookingDetailArgument {
  String bookingUrn;
  String bookingId;
  String bookingType;
  String? bookingStatus;
  String? activityStatus;
  TourCancellationStatus? cancellationStatus;
  TourBookingDetailArgument({
    required this.bookingUrn,
    required this.bookingId,
    required this.bookingType,
    this.bookingStatus,
    this.activityStatus,
    this.cancellationStatus,
  });

  TourBookingDetailArgumentDomain toTourBookingDetailArgumentDomain() {
    return TourBookingDetailArgumentDomain(
      bookingId: bookingId,
      bookingUrn: bookingUrn,
      bookingType: bookingType,
    );
  }
}
