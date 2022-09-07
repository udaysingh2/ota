import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_booking_tile.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';

import '../../../../../helper/material_wrapper.dart';
import '../../../../../mocks/fixture_reader.dart';

void main() {
  Map<String, dynamic> upcoming =
      json.decode(fixture("tour/tour_upcoming_booking_mock.json"));

  BookingDetail upcomingBooking = BookingDetail.fromMap(upcoming);
  TourBookingViewModel tourUpcomingBookingViewModel =
      TourBookingViewModel.fromBookingDetailsModel(
          upcomingBooking.tour!, upcomingBooking.serviceType!);

  Map<String, dynamic> completed =
      json.decode(fixture("tour/tour_completed_booking_mock.json"));

  BookingDetail completedBooking = BookingDetail.fromMap(completed);
  TourBookingViewModel tourCompletedBookingViewModel =
      TourBookingViewModel.fromBookingDetailsModel(
          completedBooking.tour!, completedBooking.serviceType!);

  Map<String, dynamic> cancelled =
      json.decode(fixture("tour/tour_cancelled_booking_mock.json"));

  BookingDetail cancelledBooking = BookingDetail.fromMap(cancelled);
  TourBookingViewModel tourCancelledBookingViewModel =
      TourBookingViewModel.fromBookingDetailsModel(
          cancelledBooking.tour!, cancelledBooking.serviceType!);

  TestWidgetsFlutterBinding.ensureInitialized();
  group("Tour booking tile Test", () {
    testWidgets('Tour booking tile upcoming Test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget = getMaterialWrapper(TourBookingTile(
          tourBookings: tourUpcomingBookingViewModel,
          onTap: () {},
        ));
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.pump();
      });
    });

    testWidgets('Tour booking tile completed Test',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget = getMaterialWrapper(TourBookingTile(
          tourBookings: tourCompletedBookingViewModel,
          onTap: () {},
        ));
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.pump();
      });
    });

    testWidgets('Tour booking tile cancelled Test',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget = getMaterialWrapper(TourBookingTile(
          tourBookings: tourCancelledBookingViewModel,
          onTap: () {},
        ));
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.pump();
      });
    });
  });
}
