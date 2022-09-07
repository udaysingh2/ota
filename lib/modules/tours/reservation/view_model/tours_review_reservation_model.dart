import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_argument.dart';

class TourReviewReservationModel {
  TourReviewReservationArgument argument;
  TourReviewReservationViewModel reviewReservationData;
  double lastPrice;
  int adultCount;
  int childCount;
  TourReviewReservationModel({
    required this.argument,
    required this.reviewReservationData,
    required this.lastPrice,
    required this.adultCount,
    required this.childCount,
  });
}
