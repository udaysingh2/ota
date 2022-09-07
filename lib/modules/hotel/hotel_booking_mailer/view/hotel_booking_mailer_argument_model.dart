class HotelBookingMailerArgumentModel {
  String? bookingConfirmNo;
  String? bookingUrn;
  bool? car;
  String? serviceName;
  HotelBookingMailerArgumentModel(
      {required this.bookingUrn,
      required this.bookingConfirmNo,
      this.car,
      this.serviceName});
}
