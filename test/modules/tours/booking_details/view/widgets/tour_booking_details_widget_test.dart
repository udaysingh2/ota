import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancel_default_gradient.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  group("Ota top detail Section Widget", () {
    testWidgets('Tour Booking Details', (tester) async {
      Widget widget = getMaterialWrapper(TourBookingDetailsWidget(
        onTap: () {},
        isDisableCancellation: true,
        isDisabledContact: false,
        isDisabledEmailConfirmation: false,
        onMessageTap: () {},
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaCancelDefaultGradient).at(1));
      await tester.pumpAndSettle();
    });
    testWidgets('Tour Booking Details 2', (tester) async {
      Widget widget = getMaterialWrapper(TourBookingDetailsWidget(
        onTap: () {},
        isDisableCancellation: true,
        isDisabledContact: true,
        isDisabledEmailConfirmation: true,
        onMessageTap: () {},
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
