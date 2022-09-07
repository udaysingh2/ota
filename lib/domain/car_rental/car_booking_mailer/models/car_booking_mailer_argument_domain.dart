class CarBookingMailerArgumentDomain {
  final String confirmNo;
  final String mailId;
  final String? bookingUrn;
  final String? serviceName;
  CarBookingMailerArgumentDomain({
    required this.confirmNo,
    required this.mailId,
    this.serviceName,
    this.bookingUrn,
  });
}
