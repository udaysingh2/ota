import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';

void main() {
  test('Cancellation Policy Model Test', () async {
    // Build our app and trigger a frame.
    CancellationPolicyModel cancellationPolicyModel = CancellationPolicyModel();
    expect(cancellationPolicyModel.cancellationPolicyState,
        CancellationPolicyState.conditionalCancellation);
    await Future.delayed(const Duration(milliseconds: 100));
    cancellationPolicyModel.cancellationPolicyState =
        CancellationPolicyState.freeCancellation;
    expect(cancellationPolicyModel.cancellationPolicyState,
        CancellationPolicyState.freeCancellation);
    await Future.delayed(const Duration(milliseconds: 100));
    cancellationPolicyModel.cancellationPolicyState =
        CancellationPolicyState.nonRefundable;
    expect(cancellationPolicyModel.cancellationPolicyState,
        CancellationPolicyState.nonRefundable);
  });
}
