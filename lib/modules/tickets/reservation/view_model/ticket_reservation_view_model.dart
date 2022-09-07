import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';

class TicketReservationViewModel {
  TicketReviewReservationViewModel? reservationViewModel;
  TicketReviewReservationScreenState screenState;
  TicketReservationViewModel({
    required this.screenState,
    this.reservationViewModel,
  });
}

enum TicketReviewReservationScreenState {
  loading,
  none,
  success,
  failure,
  failureToken,
  failureUnavailable,
  internetFailure,
}
