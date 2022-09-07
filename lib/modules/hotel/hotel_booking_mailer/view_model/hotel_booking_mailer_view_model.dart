class HotelBookingMailerViewModel {
  String actionStatus;
  HotelBookingMailerState hotelBookingMailerStatus;
  HotelBookingMailerViewModel({
    required this.actionStatus,
    this.hotelBookingMailerStatus = HotelBookingMailerState.none,
  });
}

enum HotelBookingMailerState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
