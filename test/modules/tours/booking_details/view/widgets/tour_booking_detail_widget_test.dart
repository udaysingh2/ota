import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_detail_widget.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_expandable_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  final TourExpandableController controller = TourExpandableController();
  testWidgets('Tour Booking Detail Widget', (tester) async {
    Widget widget = getMaterialWrapper(
      TourBookingDetailWidget(
        controller: controller,
        childCount: 1,
        title: "Wat Arun(Holiday by RBH)",
        facilityMap: [
          TourBookingDetailsHighlight(value: "Full day tour starts at 08:00 AM",key: "tourTime")
        ],
        childrenPricePerNight: 100,
        childInfo: ToursChildInfo(maxAge: 12, minAge: 3),
        adultPricePerNight: 400,
      ),
    );
    controller.state.state = TourExpandableModelState.expanded;
    controller.emit(controller.state);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
