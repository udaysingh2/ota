import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_argument_domain.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';

class TicketReviewReservationArgument {
  String ticketId;
  String countryId;
  String cityId;
  DateTime bookingDate;
  String currency;
  double price;
  String refCode;
  String rateKey;
  String serviceId;
  String zoneId;
  List<TicketReservationArgument> ticketReservationArgument;
  String startTime;
  String timeOfDay;
  String serviceType;

  TicketReviewReservationArgument(
      {required this.ticketId,
      required this.countryId,
      required this.cityId,
      required this.bookingDate,
      required this.currency,
      required this.price,
      required this.refCode,
      required this.rateKey,
      required this.serviceId,
      required this.zoneId,
      required this.ticketReservationArgument,
      required this.startTime,
      required this.timeOfDay,
      required this.serviceType});

  TicketReviewReservationArgumentDomain toTicketReviewReservationDomain() {
    return TicketReviewReservationArgumentDomain(
      ticketId: ticketId,
      countryId: countryId,
      cityId: cityId,
      bookingDate: Helpers.getYYYYmmddFromDateTime(bookingDate),
      price: price,
      currency: currency,
      refCode: refCode,
      rateKey: rateKey,
      serviceId: serviceId,
      zoneId: zoneId,
      ticketPackageReservationArgument: List.generate(
        ticketReservationArgument.length,
        (index) => ticketReservationArgument
            .elementAt(index)
            .toTicketPackageReviewReservationDomain(),
      ),
      startTime: startTime,
      timeOfDay: timeOfDay,
      serviceType: serviceType,
      ticketPackageFilter: toTicketPackageFilterArgumentDomain(),
    );
  }

  TicketPackageFilterArgumentDomain toTicketPackageFilterArgumentDomain() {
    return TicketPackageFilterArgumentDomain(
        paxType: List.generate(
      ticketReservationArgument.length,
      (index) => toPaxTypeArgumentDomain(
          ticketReservationArgument.elementAt(index).paxId!, 1),
    ));
  }

  PaxTypeArgumentDomain toPaxTypeArgumentDomain(String paxId, int quantity) {
    return PaxTypeArgumentDomain(code: paxId, quantity: quantity);
  }
}

class TicketReservationArgument {
  String? name;
  String? paxId;
  double? price;
  int? noOfTickets;

  TicketReservationArgument({
    required this.name,
    required this.paxId,
    required this.price,
    required this.noOfTickets,
  });

  TicketTypesReservationArgumentDomain
      toTicketPackageReviewReservationDomain() {
    return TicketTypesReservationArgumentDomain(
      name: name!,
      paxId: paxId!,
      price: price!,
      noOfTickets: noOfTickets!,
    );
  }

  TicketReservationArgument.mapFromTicketType(TicketTypes ticketType) {
    name = ticketType.name;
    paxId = ticketType.paxId;
    price = ticketType.price;
    noOfTickets = ticketType.ticketCount;
  }

  TicketReservationArgument.mapFromTicketTypeViewModel(
      TicketTypeViewModel ticketType) {
    name = ticketType.name;
    paxId = ticketType.paxId;
    price = ticketType.price;
    noOfTickets = ticketType.noOfTickets;
  }
}
