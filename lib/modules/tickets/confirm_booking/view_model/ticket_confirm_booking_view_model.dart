import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';

class TicketConfirmBookingArgumentModel {
  final OtaCountDownController otaCountDownController;
  final ConfirmBookingArgument argument;

  TicketConfirmBookingArgumentModel({
    required this.otaCountDownController,
    required this.argument,
  });
}
