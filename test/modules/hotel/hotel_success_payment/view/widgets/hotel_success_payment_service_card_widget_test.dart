import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view/widgets/hotel_success_payment_service_card_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Service Card Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(const HotelSuccessPaymentServiceCardWidget());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
