import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/bloc/tour_cancellation_reason_bloc.dart';

void main() {
  testWidgets('cancellation reason bloc ...', (tester) async {
    TourCancellationReasonBloc cancellationReasonBloc =
        TourCancellationReasonBloc();
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
