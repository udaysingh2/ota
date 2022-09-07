import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

class TourConfirmBookingModel {
  final OtaCountDownController otaCountDownController;
  final ConfirmBookingArgument argument;
  final int adultCount;
  final int childCount;
  final double adultTourPrice;
  final double childTourPrice;
  final String cancellationPolicy;
  final ToursChildInfo childInfo;
  final bool isAllTravellersInfoRequired;

  TourConfirmBookingModel({
    required this.otaCountDownController,
    required this.argument,
    required this.adultCount,
    required this.childCount,
    required this.adultTourPrice,
    required this.childTourPrice,
    required this.cancellationPolicy,
    required this.childInfo,
    required this.isAllTravellersInfoRequired,
  });
}
