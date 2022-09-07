import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

class TourReservationViewModel {
  TourReviewReservationViewModel? reservationViewModel;
  TourReviewReservationScreenState screenState;
  TourReservationViewModel({
    required this.screenState,
    this.reservationViewModel,
  });
}

enum TourReviewReservationScreenState {
  loading,
  none,
  success,
  failure,
  failureToken,
  failureUnavailable,
  failureMinimumLimit,
  internetFailure,
}
