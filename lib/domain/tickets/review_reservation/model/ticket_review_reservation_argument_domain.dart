import 'package:ota/common/utils/string_extension.dart';

class TicketReviewReservationArgumentDomain {
  String ticketId;
  String countryId;
  String cityId;
  String bookingDate;
  String currency;
  double price;
  String refCode;
  String rateKey;
  String serviceId;
  String zoneId;
  String timeOfDay;
  String startTime;
  String serviceType;
  TicketPackageFilterArgumentDomain ticketPackageFilter;
  List<TicketTypesReservationArgumentDomain> ticketPackageReservationArgument;

  TicketReviewReservationArgumentDomain({
    required this.ticketId,
    required this.countryId,
    required this.cityId,
    required this.bookingDate,
    required this.currency,
    required this.price,
    required this.refCode,
    required this.rateKey,
    required this.serviceId,
    required this.zoneId,
    required this.timeOfDay,
    required this.startTime,
    required this.serviceType,
    required this.ticketPackageFilter,
    required this.ticketPackageReservationArgument,
  });
}

class TicketTypesReservationArgumentDomain {
  String paxId;
  String name;
  double price;
  int noOfTickets;

  TicketTypesReservationArgumentDomain({
    required this.paxId,
    required this.name,
    required this.price,
    required this.noOfTickets,
  });

  Map<String, dynamic> toMap() => {
        "paxId": paxId.addQuote(),
        "name": name.addQuote(),
        "price": price,
        "noOfTickets": noOfTickets,
      };
}

class TicketPackageFilterArgumentDomain {
  List<PaxTypeArgumentDomain> paxType;

  TicketPackageFilterArgumentDomain({
    required this.paxType,
  });

  Map<String, dynamic> toMap() => {
        "paxType": paxType.map((x) => x.toMap()).toList(),
      };
}

class PaxTypeArgumentDomain {
  String code;
  int quantity;

  PaxTypeArgumentDomain({
    required this.code,
    required this.quantity,
  });

  Map<String, dynamic> toMap() =>
      {"code": code.surroundWithDoubleQuote(), "quantity": quantity};
}

extension StringQuote on String {
  String addQuote() {
    return "\"${this}\"";
  }
}
