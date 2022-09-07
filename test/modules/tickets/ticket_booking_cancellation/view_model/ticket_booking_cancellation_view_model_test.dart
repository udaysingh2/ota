import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_model_domain.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_cancellation_reason_view_model.dart';

void main() {
  testWidgets('ticket booking cancellation view model ...', (tester) async {
    final refund = Refund(
      processingFee: 10.0,
      refundAmount: 200.0,
      reservationCancellationFee: 12.0,
    );

    final ticketBookingReject = GetTicketBookingReject(
        data: Data(
      actionStatus: 'success',
      cancellationDate: '2022-09-23',
      refund: refund,
      totalAmount: 300.0,
    ));

    final ticketBookingRejectFailure = GetTicketBookingReject(
        data: Data(
      actionStatus: 'fail',
      cancellationDate: '2022-09-23',
      refund: refund,
      totalAmount: 300.0,
    ));

    final cancellationReasonModel = TicketCancellationReasonViewModel(
      cancellationReason: 'Plan changed',
      isSelected: true,
    );

    final bookingCancellationData =
        TicketBookingCancellationData.fromDomain(ticketBookingReject);

    final cancellationViewModel = TicketBookingCancellationViewModel(
      state: TicketBookingCancellationScreenStates.success,
      cancellationReasonViewModel: cancellationReasonModel,
      data: bookingCancellationData,
    );

    final cancellationViewModelFailure = TicketBookingCancellationViewModel(
      state: TicketBookingCancellationScreenStates.failure,
      cancellationReasonViewModel: cancellationReasonModel,
      data:
          TicketBookingCancellationData.fromDomain(ticketBookingRejectFailure),
    );

    expect(
        cancellationViewModel.cancellationReasonViewModel?.cancellationReason,
        cancellationReasonModel.cancellationReason);
    expect(cancellationViewModel.cancellationReasonViewModel?.isSelected,
        cancellationReasonModel.isSelected);
    expect(cancellationViewModel.state,
        TicketBookingCancellationScreenStates.success);
    expect(cancellationViewModel.data?.cancellationDate,
        bookingCancellationData.cancellationDate);
    expect(cancellationViewModel.data?.refundData?.refundAmount,
        refund.refundAmount);
    expect(cancellationViewModelFailure.data?.actionStatus,
        TicketCancellationStatus.failure);
  });
}
