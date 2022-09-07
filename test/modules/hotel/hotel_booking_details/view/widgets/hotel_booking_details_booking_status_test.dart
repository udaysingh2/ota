import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_booking_status.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("hotel booking details booking status", (tester) async {
    Widget widget = getMaterialWrapper(const HotelBookingDetailsBookingStatus(
      state: ActivityStatus.bookingSuccess,
      activityStatus: "",
      bookingId: '',
      referenceId: '',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets("hotel booking details booking status", (tester) async {
    Widget widget = getMaterialWrapper(const HotelBookingDetailsBookingStatus(
      state: ActivityStatus.completed,
      activityStatus: 'activityStatus',
      referenceId: '2',
      bookingId: '1',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
