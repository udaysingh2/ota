import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/ticket_booking_cancellation/models/ticket_booking_cancellation_argument_model.dart';

void main() {
  test('For class RemovePromoCodeArgumentDomain then', () {
    TicketBookingCancellationArgumentDomain actual =
        TicketBookingCancellationArgumentDomain(
            confirmationNo: '', cancellationReason: '');

    expect(actual.confirmationNo.isNotEmpty, false);
    expect(actual.confirmationNo, '');
    expect(actual.cancellationReason.isNotEmpty, false);
    expect(actual.cancellationReason, '');
  });
}
