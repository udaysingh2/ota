import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/booking_details_refund_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('booking details refund widget ...', (tester) async {
    Widget widget = getMaterialWrapper(BookingDetailsRefundWidget(
      operationFee: 2000.00,
      totalRefund: 1000.00,
      cancellationFee: 500.00,
      netPrice: 1200.00,
      showHeader: true,
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(OtaGradientText), findsOneWidget);
  });
}
