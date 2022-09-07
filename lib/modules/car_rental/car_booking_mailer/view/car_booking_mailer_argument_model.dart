class CarBookingMailerArgumentModel {
  String? bookingConfirmNo;
  String? bookingUrn;
  String? serviceName;
  CarBookingMailerArgumentModel(
      {required this.bookingUrn,
      required this.bookingConfirmNo,
      this.serviceName});
}
