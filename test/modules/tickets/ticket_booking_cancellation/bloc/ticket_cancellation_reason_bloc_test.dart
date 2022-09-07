import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/bloc/ticket_cancellation_reason_bloc.dart';

void main() {
  testWidgets('cancellation reason bloc ...', (tester) async {
    TicketCancellationReasonBloc cancellationReasonBloc =
        TicketCancellationReasonBloc();
    cancellationReasonBloc.setCancellationReason(
        index: 1, isSelected: true, reason: 'test');
    expect(cancellationReasonBloc.state.cancellationReason == 'test', true);
    expect(cancellationReasonBloc.state.isSelected, true);
    expect(
        cancellationReasonBloc.getBookingAndConfirmationDateSame(
            bookingDateValue: '2022-05-09',
            confirmationDateValue: '2022-05-09 18:38:45'),
        false);
  });
}
