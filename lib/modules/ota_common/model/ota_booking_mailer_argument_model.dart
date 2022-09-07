class OtaBookingMailerArgumentModel {
  String bookingConfirmNo;
  String bookingUrn;
  String bookingType;
  OtaBookingMailerArgumentModel(
      {required this.bookingUrn,
      required this.bookingConfirmNo,
      required this.bookingType});
}
