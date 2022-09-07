import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/details/models/tour_package_details_argument_domain.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tours_review_reservation_argument.dart';

class TourBookingCalendarArgument {
  final ServiceType serviceType;
  final String packageName;
  final double adultPrice;
  final double childPrice;
  DateTime selectedDate;
  final String countryId;
  final String cityId;
  final String tourTicketId;
  final String rateKey;
  final String currency;
  final String serviceCategory;
  final String serviceId;
  final String zoneId;
  final int availableSeats;
  final int minimumSeats;
  final String timeOfDay;
  final String startTime;
  final String refCode;

  TourBookingCalendarArgument({
    required this.packageName,
    required this.adultPrice,
    required this.childPrice,
    required this.serviceType,
    required this.selectedDate,
    required this.countryId,
    required this.cityId,
    required this.tourTicketId,
    required this.rateKey,
    required this.currency,
    required this.serviceCategory,
    required this.serviceId,
    required this.zoneId,
    required this.availableSeats,
    required this.minimumSeats,
    required this.timeOfDay,
    required this.startTime,
    required this.refCode,
  });

  bool get isTourServiceType => serviceType == ServiceType.tour;

  factory TourBookingCalendarArgument.fromTourDetailArgument(
    TourDetailArgument argument,
    String rateKey,
    String currency,
    String packageName,
    double adultPrice,
    double childPrice,
    String serviceCategory,
    String serviceId,
    String zoneId,
    int availableSeats,
    int minimumSeats,
    String timeOfDay,
    String startTime,
    String refCode,
  ) {
    return TourBookingCalendarArgument(
      serviceType: ServiceType.tour,
      selectedDate: argument.tourDateTime,
      countryId: argument.countryId,
      cityId: argument.cityId,
      tourTicketId: argument.tourId,
      rateKey: rateKey,
      currency: currency,
      packageName: packageName,
      adultPrice: adultPrice,
      childPrice: childPrice,
      serviceCategory: serviceCategory,
      serviceId: serviceId,
      zoneId: zoneId,
      availableSeats: availableSeats,
      minimumSeats: minimumSeats,
      timeOfDay: timeOfDay,
      startTime: startTime,
      refCode: refCode,
    );
  }
  TourPackageDetailsArgumentDomain toTourPackageDomainArgument() {
    return TourPackageDetailsArgumentDomain(
        refCode: refCode,
        serviceId: serviceId,
        serviceType: serviceCategory,
        tourId: tourTicketId,
        tourDate: Helpers.getYYYYmmddFromDateTime(selectedDate),
        countryId: countryId,
        cityId: cityId,
        rateKey: rateKey,
        adults: minimumSeats,
        children: minimumSeats,
        timeOfDay: timeOfDay,
        startTime: startTime);
  }

  TourReviewReservationArgument toTourReviewReservationArgument(
      TourPackageModel tourPackageModel) {
    return TourReviewReservationArgument(
      tourId: tourTicketId,
      countryId: countryId,
      cityId: cityId,
      bookingDate: selectedDate,
      totalPrice: tourPackageModel.totalPrice,
      refCode: refCode,
      rateKey: rateKey,
      serviceId: serviceId,
      zoneId: zoneId,
      timeOfDay: timeOfDay,
      startTime: startTime,
      packageReservationArgument: PackageReservationArgument(
        name: packageName,
        adultPaxId: tourPackageModel.adultPaxId,
        childPaxId: tourPackageModel.childPaxId,
        adultPrice: adultPrice,
        childPrice: childPrice,
        children: tourPackageModel.childCount,
        adults: tourPackageModel.adultCount,
      ),
      currency: currency,
      serviceType: serviceCategory,
      childAge: tourPackageModel.childAgeList,
    );
  }
}

enum ServiceType { tour, ticket }
