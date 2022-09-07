import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';

class QueriesTicketBookingCancellation {
  static String getTicketBookingCancellationData(
      TicketBookingCancellationArgumentDomain argument) {
    return '''
query {
  getTicketBookingReject(
    ticketBookingRejectRequest: {
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
