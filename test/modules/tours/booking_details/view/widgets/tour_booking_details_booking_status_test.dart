import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_booking_status.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("Tour booking details booking status for completedBooking",
      (tester) async {
    Widget widget = getMaterialWrapper(const TourBookingDetailsBookingStatus(
      bookingId: "12345",
      referenceId: "referenceId",
      orderId: "orderId",
      bookingStatus: "Success",
      statusType: TourAndTicketBookingStatus.bookingCompleted,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets("tour booking details booking status for ongoingBooking",
      (tester) async {
    Widget widget = getMaterialWrapper(
      const TourBookingDetailsBookingStatus(
        bookingId: "12345",
        referenceId: "referenceId",
        orderId: "orderId",
        bookingStatus: "Success",
        statusType: TourAndTicketBookingStatus.bookingConfirmed,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets("tour booking details booking status for canceledBookings ",
      (tester) async {
    Widget widget = getMaterialWrapper(
      const TourBookingDetailsBookingStatus(
        bookingId: "12345",
        referenceId: "referenceId",
        orderId: "orderId",
        bookingStatus: "Success",
        statusType: TourAndTicketBookingStatus.bookingCancelled,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
