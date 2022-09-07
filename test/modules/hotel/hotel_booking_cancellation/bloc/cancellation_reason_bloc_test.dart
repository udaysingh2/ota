import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/bloc/cancellation_reason_bloc.dart';

void main() {
  testWidgets('cancellation reason bloc ...', (tester) async {
    CancellationReasonBloc cancellationReasonBloc = CancellationReasonBloc();
    cancellationReasonBloc.setCancellationReason(
        index: 1, isSelected: true, reason: 'test');
    expect(cancellationReasonBloc.state.cancellationReason == 'test', true);
    expect(cancellationReasonBloc.state.isSelected, true);
  });
}
