import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_controller.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';

void main() {
  test('Cancellation Policy Controller Test', () async {
    // Build our app and trigger a frame.
    CancellationPolicyController cancellationPolicyController =
        CancellationPolicyController();
    expect(cancellationPolicyController.state.cancellationPolicyState,
        CancellationPolicyState.conditionalCancellation);
    await Future.delayed(const Duration(milliseconds: 100));

    cancellationPolicyController.setfreeCancellation();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(cancellationPolicyController.state.cancellationPolicyState,
        CancellationPolicyState.freeCancellation);

    cancellationPolicyController.setnonRefundable();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(cancellationPolicyController.state.cancellationPolicyState,
        CancellationPolicyState.nonRefundable);

    cancellationPolicyController.setconditionalCancellation();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(cancellationPolicyController.state.cancellationPolicyState,
        CancellationPolicyState.conditionalCancellation);
  });
}
