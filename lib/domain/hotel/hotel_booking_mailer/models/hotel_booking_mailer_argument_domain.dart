class HotelBookingMailerArgumentDomain {
  final String confirmNo;
  final String mailId;
  final String? bookingUrn;
  final String? serviceName;
  HotelBookingMailerArgumentDomain({
    required this.confirmNo,
    required this.mailId,
    this.serviceName,
    this.bookingUrn,
  });
}
