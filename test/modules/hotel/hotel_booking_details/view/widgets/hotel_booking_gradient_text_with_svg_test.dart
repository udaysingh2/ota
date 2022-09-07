import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_gradient_text_with_svg.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets("gradient text with svg test", (tester) async {
    Widget widget = getMaterialWrapper(const HotelBookingDetailsWithGradient(
      gradientText: '',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
