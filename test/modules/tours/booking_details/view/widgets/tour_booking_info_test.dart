import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_info.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import '../../../../../helper/material_wrapper.dart';

void main(){
  testWidgets('Tour Booking Info', (tester) async {
    Widget widget = getMaterialWrapper(TourBookingInfo(
      adultPricePerNight: 300.00,
      childrenPricePerNight: 100.00,
      childCount: 1,
      childInfo: ToursChildInfo(minAge: 3, maxAge: 9),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}