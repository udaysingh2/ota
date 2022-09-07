class CarBookingMailerViewModel {
  String actionStatus;
  CarBookingMailerState carBookingMailerStatus;
  CarBookingMailerViewModel({
    required this.actionStatus,
    this.carBookingMailerStatus = CarBookingMailerState.none,
  });
}

enum CarBookingMailerState {
  none,
  loading,
  success,
  failure,
  failureNetwork,
}
