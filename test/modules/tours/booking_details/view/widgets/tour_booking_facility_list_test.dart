import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_facility_list.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("Tour Booking Facility testing", (tester) async {
    Widget widget = getMaterialWrapper(
      TourBookingFacilityList(
        facilityMap: [TourBookingDetailsHighlight(key: "key", value: "value")],
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
