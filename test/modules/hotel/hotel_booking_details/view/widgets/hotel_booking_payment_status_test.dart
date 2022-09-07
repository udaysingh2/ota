import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_payment_status.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets("hotel booking payment status test", (tester) async {
    Widget widget = getMaterialWrapper(const HotelBookingDetailsPaymentStatus(
      paymentStatus: '',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
