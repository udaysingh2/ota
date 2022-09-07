import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_controller.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';

import '../../../../../../helper/material_wrapper.dart';

void main() {
  List<CancellationPolicyModel> cancellationPolicy = [
    CancellationPolicyModel(
        cancellationDaysDescription:
            "You have to cancel 3 day(s) prior to the service date.",
        cancellationChargeDescription:
            "Otherwise cancellation charge of Full Charge from Grand total will be applied."),
    CancellationPolicyModel(
        cancellationDaysDescription:
            "You have to cancel 3 day(s) prior to the service date.",
        cancellationChargeDescription:
            "Otherwise cancellation charge of Full Charge from Grand total will be applied."),
    CancellationPolicyModel(
        cancellationDaysDescription:
            "You have to cancel 3 day(s) prior to the service date.",
        cancellationChargeDescription:
            "Otherwise cancellation charge of Full Charge from Grand total will be applied."),
  ];

  testWidgets('Cancellation Policy Test', (WidgetTester tester) async {
    CancellationPolicyController cancellationPolicyController =
        CancellationPolicyController();
    List<CancellationPolicyModel> cancellationPolicyModel = cancellationPolicy;
    Widget widget = getMaterialWrapper(
      CancellationPolicy(
        cancellationPolicyModel: cancellationPolicyModel,
        cancellationPolicyController: cancellationPolicyController,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    cancellationPolicyController.setfreeCancellation();
    await tester.pumpAndSettle();

    cancellationPolicyController.setnonRefundable();
    await tester.pumpAndSettle();

    cancellationPolicyController.setconditionalCancellation();
    await tester.pumpAndSettle();
  });
}
