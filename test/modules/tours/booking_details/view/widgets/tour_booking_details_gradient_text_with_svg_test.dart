import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_gradient_text_with_svg.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets("tour gradient text with svg test", (tester) async {
    Widget widget = getMaterialWrapper(const TourBookingDetailsWithGradient(
      gradientText: '',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
  testWidgets("tour gradient text with svg test with isGradientText false",
      (tester) async {
    Widget widget = getMaterialWrapper(const TourBookingDetailsWithGradient(
      gradientText: 'text',
      isGradientText: false,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
