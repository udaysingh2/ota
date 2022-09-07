import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_payment_status.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets("tour booking payment status test", (tester) async {
    Widget widget = getMaterialWrapper(const TourBookingDetailsPaymentStatus(
      paymentStatus: "Success",
      netPrice: 999.0,
      totalPrice: 1000.0,
      discount: 100.0,
      cardNickname: "SCB Easy",
      cardNo: "4444111122223333",
      paymentType: PaymentMethodType.scb,
      status: TourAndTicketBookingStatus.unsuccessfulPayment,
      isTour: true,
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
