import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';

class TicketConfirmBookingViewModel {
  TicketConfirmBookingScreenState state;
  TicketConfirmBookingModel? data;

  TicketConfirmBookingViewModel({
    required this.state,
    this.data,
  });
}

enum TicketConfirmBookingScreenState {
  initial,
  loading,
  success,
  failure,
  internetFailure,
}
