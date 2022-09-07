import 'package:ota/domain/hotel/hotel_booking_details/models/hotel_booking_details_argument_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_view_model.dart';

class HotelBookingDetailArgument {
  String bookingUrn;
  String confirmationNo;
  String? bookingStatus;
  String? activityStatus;
  String? cancelDate;
  CancellationStatus? cancellationStatus;
  HotelBookingDetailArgument({
    required this.bookingUrn,
    required this.confirmationNo,
    this.bookingStatus,
    this.activityStatus,
    this.cancelDate,
    this.cancellationStatus,
  });

  HotelBookingDetailArgumentDomain toHotelBookingDetailArgumentDomain() {
    return HotelBookingDetailArgumentDomain(
      confirmationNo: confirmationNo,
      bookingUrn: bookingUrn,
    );
  }
}
