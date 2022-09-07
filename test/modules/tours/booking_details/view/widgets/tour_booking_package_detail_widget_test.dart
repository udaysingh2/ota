import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_package_detail_widget.dart';
import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Booking Package Details Widget', (tester) async {
    Widget widget = getMaterialWrapper(TourBookingPackageDetailWidget(
      titleKey: "package details",
      onTap: () {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
