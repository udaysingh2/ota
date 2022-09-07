import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_meeting_point_widget.dart';
import '../../../../../helper/material_wrapper.dart';

void main(){
  testWidgets('Tour Booking Meeting Point', (tester) async {
    Widget widget = getMaterialWrapper(const TourBookingMeetingPointWidget(
      meetingPoint: "โรงแรมเซนทารา กรุงเทพ",
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}