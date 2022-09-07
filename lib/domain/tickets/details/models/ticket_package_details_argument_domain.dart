import 'package:ota/common/utils/string_extension.dart';

class TicketPackageDetailsArgumentDomain {
  int? adults;
  int? children;
  String countryId;
  String cityId;
  String ticketId;
  String ticketDate;
  String refCode;
  String rateKey;
  String serviceId;
  String timeOfDay;
  String startTime;
  String serviceType;
  List<PaxTypeArgumentDomain> paxType;

  TicketPackageDetailsArgumentDomain({
    this.adults,
    this.children,
    required this.countryId,
    required this.cityId,
    required this.ticketId,
    required this.ticketDate,
    required this.refCode,
    required this.rateKey,
    required this.serviceId,
    required this.timeOfDay,
    required this.startTime,
    required this.serviceType,
    required this.paxType,
  });

  Map<String, dynamic> toMap() => {
        if (adults != null) "adults": adults,
        if (children != null) "children": children,
        "countryId": countryId.surroundWithDoubleQuote(),
        "cityId": cityId.surroundWithDoubleQuote(),
        "ticketId": ticketId.surroundWithDoubleQuote(),
        "ticketDate": ticketDate.surroundWithDoubleQuote(),
        "refCode": refCode.surroundWithDoubleQuote(),
        "rateKey": rateKey.surroundWithDoubleQuote(),
        "serviceId": serviceId.surroundWithDoubleQuote(),
        "timeOfDay": timeOfDay.surroundWithDoubleQuote(),
        "startTime": startTime.surroundWithDoubleQuote(),
        "serviceType": serviceType.surroundWithDoubleQuote(),
        "paxType": paxType.map((x) => x.toMap()).toList()
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
