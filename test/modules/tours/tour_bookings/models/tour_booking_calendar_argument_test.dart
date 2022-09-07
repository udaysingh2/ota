import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_argument.dart';

void main() {
  test('OTA booking Calendar argument', () async {
    final otaBookingCalendarArgument1 =
        TourBookingCalendarArgument.fromTourDetailArgument(
            TourDetailArgument(
              countryId: "MA05110001",
              cityId: "MA05110041",
              tourId: "MA2110000413",
              userType: TourDetailUserType.loggedInUser,
              tourDate: "10-12-21",
            ),
            "TUEyMTEwMDAwMzcz",
            "THB",
            "packageName",
            300.00,
            150.00,
            "SIC",
            "MA21110100",
            "MA21110009",
            3,
            3,
            "AM",
            "10:00",
            "CL213");
    final otaBookingCalendarArgument = TourBookingCalendarArgument(
        rateKey: "TUEyMTEwMDAwMzcz",
        currency: "THB",
        packageName: "packageName",
        childPrice: 123.00,
        adultPrice: 222.00,
        cityId: "MA05110041",
        countryId: "MA05110001",
        selectedDate: DateTime.now(),
        serviceType: ServiceType.tour,
        availableSeats: 13,
        minimumSeats: 3,
        timeOfDay: "AM",
        startTime: "10:00",
        refCode: "CL213",
        serviceCategory: "SIC",
        serviceId: "MA21110100",
        zoneId: "MA21110009",
        tourTicketId: "MA2110000413");
    expect(otaBookingCalendarArgument.serviceType, ServiceType.tour);
    expect(otaBookingCalendarArgument1.adultPrice, 300.0);
  });
}
