import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_payment_card_item.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("Tour payment card item test", (tester) async {
    Widget widget = getMaterialWrapper(
      const TourPaymentCardItem(
        showDivider: false,
        paymentType: PaymentMethodType.jcb,
        cardName: "SCB",
        cardNumber: "126263533535",
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
