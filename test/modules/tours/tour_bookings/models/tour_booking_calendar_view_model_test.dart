import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_view_model.dart';

void main() {
  TourPackageModel tourPackageModel = TourPackageModel(
      adultCount: 2,
      adultPrice: 111.00,
      availableSeats: 4,
      childAgeList: [2, 3],
      childCount: 3,
      childMaxAge: 4,
      childMinAge: 1,
      childPrice: 55.00,
      minimumSeats: 2,
      packageName: "PackageOne",
      totalPrice: 166.00);

  TourPackageModel tourPackageModel1 = TourPackageModel.fromTourPackage(Package(
    adultPrice: 222.00,
    childPrice: 111.00,
  ));

  test('OTA Booking Calendar view model', () {
    TourBookingCalendarViewModel otaBookingCalendarViewModel =
        TourBookingCalendarViewModel(
            tourPackageModel: tourPackageModel,
            bookingCalendarState: BookingCalendarState.success);
    expect(otaBookingCalendarViewModel.bookingCalendarState,
        BookingCalendarState.success);
  });
  test('OTA Booking Calendar view model', () {
    TourBookingCalendarViewModel otaBookingCalendarViewModel =
        TourBookingCalendarViewModel(
            tourPackageModel: tourPackageModel1,
            bookingCalendarState: BookingCalendarState.success);
    expect(otaBookingCalendarViewModel.bookingCalendarState,
        BookingCalendarState.success);
  });
}
