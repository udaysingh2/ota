import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_view_model.dart';

class OtaBookingCalendarHelper {
  static Package? getSelectedTourPackage(
      String rateKey, List<Package> packages) {
    for (Package package in packages) {
      if (package.rateKey == rateKey) return package;
    }
    return null;
  }

  static TourPackageModel fromTourPackage(Package tourPackage) {
    return TourPackageModel.fromTourPackage(tourPackage);
  }
}
