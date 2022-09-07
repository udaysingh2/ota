class OtaCancellationPolicyListModel {
  String? cancellationPolicyState;
  String? cancellationDaysDescription;
  String? cancellationChargeDescription;
  OtaCancellationPolicyListModelState state;
  OtaCancellationPolicyListModel({
    this.cancellationPolicyState,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
    this.state = OtaCancellationPolicyListModelState.collapsed,
  });
}

enum OtaCancellationPolicyListModelState { expanded, collapsed }
