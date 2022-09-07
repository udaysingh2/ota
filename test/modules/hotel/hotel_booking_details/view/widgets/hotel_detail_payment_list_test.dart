import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_detail_payment_list.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("hotel details payment list test", (tester) async {
    Widget widget = getMaterialWrapper(
      HotelBookingDetailPaymentList(
        totalRoomPrice: 20.0,
        totalServicePrice: 11.7,
        discountAmount: 122.2,
        grandTotal: 300,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
