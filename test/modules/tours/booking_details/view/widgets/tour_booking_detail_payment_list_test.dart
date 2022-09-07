import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_detail_payment_list.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Booking Detail Payment List Widget', (tester) async {
    Widget widget = getMaterialWrapper(
      TourBookingDetailPaymentList(
        discountAmount: 10.00,
        grandTotal: 1290.00,
        netPrice: 1200.00,
        isTour: true,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
