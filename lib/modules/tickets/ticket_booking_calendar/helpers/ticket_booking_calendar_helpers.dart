import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';

class TicketBookingCalendarHelper {
  static Package? getSelectedTicketPackage(
      String rateKey, List<Package> packages) {
    for (Package package in packages) {
      if (package.rateKey == rateKey) return package;
    }
    return null;
  }

  static TicketPackageModel fromTicketPackage(Package ticketPackage) {
    return TicketPackageModel.fromTicketPackage(ticketPackage);
  }

  static List<TicketReservationArgument> getTicketList(
      List<TicketTypes> ticketList) {
    List<TicketReservationArgument> ticketArgumentList = [];
    for (TicketTypes ticket in ticketList) {
      if (ticket.ticketCount > 0) {
        ticketArgumentList
            .add(TicketReservationArgument.mapFromTicketType(ticket));
      }
    }
    return ticketArgumentList;
  }
}
