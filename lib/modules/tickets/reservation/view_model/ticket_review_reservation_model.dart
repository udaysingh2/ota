import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';

class TicketReviewReservationModel {
  TicketReviewReservationArgument argument;
  TicketReviewReservationViewModel data;
  List<TicketTypes> ticketTypes;
  double lastPrice;
  TicketReviewReservationModel({
    required this.argument,
    required this.data,
    required this.ticketTypes,
    required this.lastPrice,
  });
}
