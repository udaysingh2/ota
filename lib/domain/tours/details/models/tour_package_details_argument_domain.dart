import 'package:ota/common/utils/string_extension.dart';

class TourPackageDetailsArgumentDomain {
  int? adults;
  int? children;
  List<String>? styleId;
  List<int>? childAge;
  bool? getMinPrice;
  String countryId;
  String cityId;
  String tourId;
  String tourDate;
  String refCode;
  String rateKey;
  String serviceId;
  String serviceType;
  String timeOfDay;
  String startTime;
  TourPackageDetailsArgumentDomain({
    this.adults,
    this.children,
    required this.countryId,
    required this.cityId,
    required this.tourId,
    required this.tourDate,
    required this.refCode,
    required this.rateKey,
    required this.serviceId,
    required this.serviceType,
    required this.timeOfDay,
    required this.startTime,
  });
  Map<String, dynamic> toMap() => {
        if (adults != null) "adults": adults,
        if (children != null) "children": children,
        if (styleId != null)
          "styleId": styleId?.map((x) => x.surroundWithDoubleQuote()).toList(),
        if (childAge != null) "childAge": childAge?.map((x) => x).toList(),
        if (getMinPrice != null) "getMinPrice": getMinPrice,
        "countryId": countryId.surroundWithDoubleQuote(),
        "cityId": cityId.surroundWithDoubleQuote(),
        "tourId": tourId.surroundWithDoubleQuote(),
        "tourDate": tourDate.surroundWithDoubleQuote(),
        "refCode": refCode.surroundWithDoubleQuote(),
        "rateKey": rateKey.surroundWithDoubleQuote(),
        "serviceId": serviceId.surroundWithDoubleQuote(),
        "serviceType": serviceType.surroundWithDoubleQuote(),
        "timeOfDay": timeOfDay.surroundWithDoubleQuote(),
        "startTime": startTime.surroundWithDoubleQuote(),
      };
}
