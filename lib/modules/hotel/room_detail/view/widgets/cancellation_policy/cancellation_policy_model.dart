class CancellationPolicyModel {
  CancellationPolicyState cancellationPolicyState;
  String? cancellationDaysDescription;
  String? cancellationChargeDescription;
  CancellationPolicyModel({
    this.cancellationPolicyState =
        CancellationPolicyState.conditionalCancellation,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
  });
}

enum CancellationPolicyState {
  freeCancellation,
  conditionalCancellation,
  nonRefundable,
}
