import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';

class TicketBookingCancellationArgument {
  final String confirmNo;
  final String reason;
  TicketBookingCancellationArgument(
      {required this.confirmNo, required this.reason});
  TicketBookingCancellationArgumentDomain toTicketBookingCancellationDomainArgument() {
    return TicketBookingCancellationArgumentDomain(
      confirmationNo: confirmNo,
      cancellationReason: reason,
    );
  }
}
