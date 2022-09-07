import 'package:ota/common/utils/string_extension.dart';

class TourReviewReservationArgumentDomain {
  String tourId;
  String countryId;
  String cityId;
  String bookingDate;
  String currency;
  double price;
  String refCode;
  String rateKey;
  String serviceId;
  String serviceType;
  String timeOfDay;
  String startTime;
  PackageReservationArgumentDomain packageReservationArgument;
  TourPackageFilter? tourPackageFilter;

  TourReviewReservationArgumentDomain({
    required this.tourId,
    required this.countryId,
    required this.cityId,
    required this.bookingDate,
    required this.currency,
    required this.price,
    required this.refCode,
    required this.rateKey,
    required this.serviceId,
    required this.serviceType,
    required this.timeOfDay,
    required this.startTime,
    required this.packageReservationArgument,
    required this.tourPackageFilter,
  });

  Map<String, dynamic> toMap() => {
        "tourId": tourId.surroundWithDoubleQuote(),
        "countryId": countryId.surroundWithDoubleQuote(),
        "cityId": cityId.surroundWithDoubleQuote(),
        "bookingDate": bookingDate.surroundWithDoubleQuote(),
        "currency": currency.surroundWithDoubleQuote(),
        "price": price,
        "refCode": refCode.surroundWithDoubleQuote(),
        "rateKey": rateKey.surroundWithDoubleQuote(),
        "serviceId": serviceId.surroundWithDoubleQuote(),
        "serviceType": serviceType.surroundWithDoubleQuote(),
        "timeOfDay": timeOfDay.surroundWithDoubleQuote(),
        "startTime": startTime.surroundWithDoubleQuote(),
        "package": packageReservationArgument.toMap(),
        "adults": packageReservationArgument.adults,
        "children": packageReservationArgument.children,
        if (tourPackageFilter != null && tourPackageFilter!.isNotEmpty)
          "tourPackageFilter": tourPackageFilter?.toMap(),
      };
}

class PackageReservationArgumentDomain {
  String name;
  String adultPaxId;
  String childPaxId;
  double adultPrice;
  double childPrice;
  int adults;
  int children;

  PackageReservationArgumentDomain({
    required this.name,
    required this.adultPaxId,
    required this.childPaxId,
    required this.adultPrice,
    required this.childPrice,
    required this.adults,
    required this.children,
  });

  Map<String, dynamic> toMap() => {
        "name": name.surroundWithDoubleQuote(),
        "adultPaxId": adultPaxId.surroundWithDoubleQuote(),
        "childPaxId": childPaxId.surroundWithDoubleQuote(),
        "adultPrice": adultPrice,
        "childPrice": childPrice,
      };
}

class TourPackageFilter {
  String? totalPrice;
  List<String>? styleId;
  List<int>? childAge;
  bool? getMinPrice;

  TourPackageFilter(
      {this.totalPrice, this.styleId, this.childAge, this.getMinPrice});

  bool get isNotEmpty =>
      (totalPrice != null && totalPrice!.isNotEmpty) ||
      (styleId != null && styleId!.isNotEmpty) ||
      (childAge != null && childAge!.isNotEmpty) ||
      getMinPrice != null;

  Map<String, dynamic> toMap() => {
        if (totalPrice != null)
          "totalPrice": totalPrice!.surroundWithDoubleQuote(),
        if (styleId != null && styleId!.isNotEmpty)
          "styleId": styleId!.map((x) => x.surroundWithDoubleQuote()).toList(),
        if (childAge != null && childAge!.isNotEmpty)
          "childAge": childAge!.map((x) => x).toList(),
        if (getMinPrice != null) "getMinPrice": getMinPrice,
      };
}
