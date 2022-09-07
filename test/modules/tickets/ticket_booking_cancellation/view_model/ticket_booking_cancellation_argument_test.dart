import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_argument.dart';

void main() {
  testWidgets('ticket booking cancellation argument ...', (tester) async {
    final ticketBookingCancellationArgument = TicketBookingCancellationArgument(
      confirmNo: 'MH984938292',
      reason: 'Plan changed',
    );

    TicketBookingCancellationArgumentDomain cancellationArgumentDomain =
        ticketBookingCancellationArgument
            .toTicketBookingCancellationDomainArgument();
    expect(cancellationArgumentDomain.cancellationReason,
        ticketBookingCancellationArgument.reason);
    expect(cancellationArgumentDomain.confirmationNo,
        ticketBookingCancellationArgument.confirmNo);
  });
}
