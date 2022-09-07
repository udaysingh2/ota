import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';

import '../../../../../helper.dart';

void main() {
  final OtaCancellationPolicyController controller =
      OtaCancellationPolicyController();
  testWidgets('Package booking Terms Widget Test', (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PackageBookingTermsWidget(
      controller: controller,
      cancellationStatus: "Cancellation Status",
      bookingTermsList: const ["Cancellation policy1", "Cancellation policy2"],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
