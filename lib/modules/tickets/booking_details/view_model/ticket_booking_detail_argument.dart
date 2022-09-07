import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_argument_model.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_view_model.dart';

class TicketBookingDetailArgument {
  String bookingUrn;
  String bookingId;
  String bookingType;
  String? bookingStatus;
  String? activityStatus;
  TicketCancellationStatus? cancellationStatus;
  TicketBookingDetailArgument({
    required this.bookingUrn,
    required this.bookingId,
    required this.bookingType,
    this.bookingStatus,
    this.activityStatus,
    this.cancellationStatus,
  });

  TicketBookingDetailArgumentDomain toTicketBookingDetailArgumentDomain() {
    return TicketBookingDetailArgumentDomain(
        bookingId: bookingId, bookingUrn: bookingUrn, bookingType: bookingType);
  }
}
