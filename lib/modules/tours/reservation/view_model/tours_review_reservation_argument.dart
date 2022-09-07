import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_argument_domain.dart';

class TourReviewReservationArgument {
  String tourId;
  String countryId;
  String cityId;
  DateTime bookingDate;
  String currency;
  double totalPrice;
  String refCode;
  String rateKey;
  String serviceId;
  String serviceType;
  String timeOfDay;
  String startTime;
  String zoneId;
  PackageReservationArgument packageReservationArgument;
  List<int> childAge;
  TourReviewReservationArgument({
    required this.tourId,
    required this.countryId,
    required this.cityId,
    required this.bookingDate,
    required this.currency,
    required this.totalPrice,
    required this.refCode,
    required this.rateKey,
    required this.serviceId,
    required this.serviceType,
    required this.timeOfDay,
    required this.startTime,
    required this.packageReservationArgument,
    required this.zoneId,
    required this.childAge,
  });

  TourReviewReservationArgumentDomain toTourReviewReservationDomain() {
    return TourReviewReservationArgumentDomain(
        tourId: tourId,
        countryId: countryId,
        cityId: cityId,
        bookingDate: Helpers.getYYYYmmddFromDateTime(bookingDate),
        price: totalPrice,
        refCode: refCode,
        rateKey: rateKey,
        serviceId: serviceId,
        packageReservationArgument:
            packageReservationArgument.toTourPackageReviewReservationDomain(),
        currency: currency,
        serviceType: serviceType,
        timeOfDay: timeOfDay,
        startTime: startTime,
        tourPackageFilter: TourPackageFilter(childAge: childAge));
  }
}

class PackageReservationArgument {
  String name;
  String adultPaxId;
  String childPaxId;
  double adultPrice;
  double childPrice;
  int adults;
  int children;
  PackageReservationArgument({
    required this.name,
    required this.adultPaxId,
    required this.childPaxId,
    required this.adultPrice,
    required this.childPrice,
    required this.adults,
    required this.children,
  });

  PackageReservationArgumentDomain toTourPackageReviewReservationDomain() {
    return PackageReservationArgumentDomain(
      name: name,
      adultPaxId: adultPaxId,
      childPaxId: childPaxId,
      adultPrice: adultPrice,
      childPrice: childPrice,
      adults: adults,
      children: children,
    );
  }
}
