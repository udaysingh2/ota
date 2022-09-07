class OtaBookingMailerViewModel {
  String actionStatus;
  OtaBookingMailerState otaBookingMailerStatus;
  OtaBookingMailerViewModel({
    required this.actionStatus,
    this.otaBookingMailerStatus = OtaBookingMailerState.none,
  });
}

enum OtaBookingMailerState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
