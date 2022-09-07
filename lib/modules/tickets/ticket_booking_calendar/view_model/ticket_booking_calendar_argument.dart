import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tickets/details/models/ticket_package_details_argument_domain.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/helpers/ticket_booking_calendar_helpers.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';

class TicketBookingCalendarArgument {
  final String packageName;
  DateTime selectedDate;
  final String countryId;
  final String cityId;
  final String ticketId;
  final String rateKey;
  final String currency;
  final String serviceId;
  final String zoneId;
  final String refCode;
  final String timeOfDay;
  final String startTime;
  final String serviceType;
  final int availableSeats;
  List<TicketTypes> ticketTypes;

  TicketBookingCalendarArgument(
      {required this.packageName,
      required this.selectedDate,
      required this.countryId,
      required this.cityId,
      required this.ticketId,
      required this.rateKey,
      required this.currency,
      required this.serviceId,
      required this.zoneId,
      required this.refCode,
      required this.ticketTypes,
      required this.timeOfDay,
      required this.startTime,
      required this.serviceType,
      required this.availableSeats,
      re});

  factory TicketBookingCalendarArgument.fromTicketDetailArgument({
    required TicketDetailArgument argument,
    required String rateKey,
    required String currency,
    required String refCode,
    required String serviceId,
    required String zoneId,
    required String packageName,
    required String timeOfDay,
    required String startTime,
    required String serviceType,
    required int availableSeats,
    required List<TicketTypeData> ticketTypeData,
  }) {
    return TicketBookingCalendarArgument(
      selectedDate: argument.ticketDateTime,
      countryId: argument.countryId,
      cityId: argument.cityId,
      ticketId: argument.ticketId,
      rateKey: rateKey,
      currency: currency,
      refCode: refCode,
      serviceId: serviceId,
      zoneId: zoneId,
      packageName: packageName,
      timeOfDay: timeOfDay,
      startTime: startTime,
      serviceType: serviceType,
      availableSeats: availableSeats,
      ticketTypes: List.generate(
        ticketTypeData.length,
        (index) => TicketTypes.mapFromTicketTypeData(
            ticketTypeData.elementAt(index), index),
      ),
    );
  }

  TicketPackageDetailsArgumentDomain toTicketPackageDetailsArgument() {
    return TicketPackageDetailsArgumentDomain(
        countryId: countryId,
        cityId: cityId,
        ticketId: ticketId,
        ticketDate: Helpers.getYYYYmmddFromDateTime(selectedDate),
        refCode: refCode,
        rateKey: rateKey,
        serviceId: serviceId,
        timeOfDay: timeOfDay,
        startTime: startTime,
        serviceType: serviceType,
        paxType: List.generate(
          ticketTypes.length,
          (index) =>
              toPaxTypeArgumentDomain(ticketTypes.elementAt(index).paxId, 1),
        ));
  }

  TicketReviewReservationArgument toTicketReviewReservationArgument(
      TicketPackageModel ticketPackageModel) {
    return TicketReviewReservationArgument(
      cityId: cityId,
      ticketId: ticketId,
      countryId: countryId,
      currency: currency,
      bookingDate: selectedDate,
      price: ticketPackageModel.totalPrice,
      refCode: refCode,
      rateKey: rateKey,
      serviceId: serviceId,
      zoneId: zoneId,
      ticketReservationArgument: TicketBookingCalendarHelper.getTicketList(
          ticketPackageModel.ticketTypes),
      timeOfDay: timeOfDay,
      startTime: startTime,
      serviceType: serviceType,
    );
  }

  PaxTypeArgumentDomain toPaxTypeArgumentDomain(String paxId, int quantity) {
    return PaxTypeArgumentDomain(code: paxId, quantity: quantity);
  }
}
